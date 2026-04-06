#!/usr/bin/perl
use strict;
#use warnings;
use Image::Magick;
use Data::Dumper;
#use lib '/home/isavnin/perl5/lib/perl5/';
use Log::Any '$log';
#use Log::Any::Adapter('Stderr', log_level => 'error');
use Log::Any::Adapter ('File','/var/www/sv-cms/htdocs/admin/logs/IM.log','log_level','error');
use POSIX qw/ceil/;

our @out = ();
our $in;
our $img;
our $pic;
our $pic_o;
our $orig;
our $project_id;
our $project_files = '/var/www/sv-cms/htdocs/files';
our $dbg;

if ( scalar @ARGV > 0 ){
  $in->{file} = $ARGV[0];
  if ( $in->{file} =~ m/^(.+)\.(.*?)$/ ){
    $in->{name} = $1;
    $in->{ext} = $2;
  }
  if ( -f $in->{file} ){
    $log->info('[info] Open file: '.$in->{file});
    &get_params;
    &start;
  }
  else {
    print "File not found!";
    $log->error('[error] File '.$in->{file}.' not found');
    exit;
  }
}
else {
  print "Error! Not found options";
  exit;
}

sub resize {

  my ( $opt ) = @_;
  #print Dumper($opt);
  if ( $opt->{project_id} ) { $project_id = $opt->{project_id}; }
  # Если указан выходной файл
  $log->info('[info] Start resize');
  if ( $opt->{output_file} ){
    # Преобразуем имя выходного файла
    $opt->{output_file} =~ s/\[%input%\]/$in->{name}/;
    $opt->{output_file} =~ s/\[%input_ext%\]/$in->{ext}/;
    if ( $opt->{output_file} =~ m/^[0-9a-zA-Z\._\-\/]+$/ ){
      $opt->{dst} = $opt->{output_file};
    }

    # Если нужен кроп
    if ( $opt->{crop} && $opt->{crop} =~ /^(\d+)x(\d+)$/ ){
      $opt->{crop_x} = $1;
      $opt->{crop_y} = $2;

      # По умолчанию вырезаем из центра
      $opt->{gravity} = 'Center' unless $opt->{gravity};
      $opt->{xypos} = '+0+0' unless $opt->{xypos};
      $log->info('[info] set crop param');
    }
  
    # Качество
    $opt->{quality} = 75;
    if ( $opt->{q} && $opt->{q} =~ /^(\d+)$/ ){
      $opt->{quality} = $1;
    }
 
    # Нужен водный знак. Без $project_id не работает, потому как по нему находим водный знак
    if ( $opt->{wm} && $opt->{wm} eq '1' && $project_id ){
      # Параметры для водного знака по умолчанию
      $opt->{wmpos} = 'Center' unless $opt->{wmpos};
      $opt->{wmxy} = '0x0' unless $opt->{wmxy};
    }

    # Ресайз для водного знака, иногда необходим
    if ( $opt->{wmresize} ){
      if ( $opt->{wmresize} =~ /^(\d+)x(\d+)$/ ){
        $opt->{wmresize} = ( $1 > 0 ? $1 : '' ) . 'x' . ( $2 > 0 ? $2 : '' );
      }
      else { $opt->{wmresize} = undef; }
    }

    if ( $opt->{wmxy} && $opt->{wmxy} =~ /^(\d+)x(\d+)$/ ){
      $opt->{wmx} = $1 > 0 ? $1 : undef;
      $opt->{wmy} = $2 > 0 ? $2 : undef;
    }

    # Размер выходного изображения
    if ( $opt->{size} && $opt->{size} =~ /^(\d+)x(\d+)$/ ){
      $opt->{resize} = ( $1 > 0 ? $1 : '' ) . 'x' . ( $2 > 0 ? $2 : '' );
      $opt->{width} = $1;
      $opt->{height} = $2;
      $opt->{orig} = 0;
      $log->info('[info] from '.$orig->{width}.'x'.$orig->{height}.' to '.$opt->{width}.'x'.$opt->{height});
      #if ( defined $opt->{width} || defined $opt->{height} ){
        if ( 
           ( !$opt->{width} && !$opt->{height} ) ||
           ( $orig->{height} >= $opt->{height} && ( $opt->{width} eq '' || $opt->{width} <= $orig->{width} )) ||
           ( $orig->{width} >= $opt->{width} && ( $opt->{height} eq '' || $opt->{height} <= $orig->{height} ) )
#          ( $opt->{width} eq '' && $opt->{height} eq '' ) ||      
#          ( $opt->{width} eq '' && $orig->{height} >= $opt->{height} ) ||
#          ( $opt->{height} eq '' && $orig->{width} >= $opt->{width} ) 
        ){
          $opt->{orig} = undef;
        }
        else { $opt->{orig} = 1; }
      #}
    }

#    $log->info('[info] orig: '.$opt->{orig});

    &go($opt);
  }
  $log->info('[info] exit resize');
}

sub start {
#  $img = Image::Magick->new;
  $log->info('[info] begin start');
  map {
    $img = Image::Magick->new;
    $log->info('[info] IM Version: ',$img->Get('version'));
    $log->info('[info] Read file',$in->{file});
    $pic = $img->Read($in->{file});
    ( $orig->{width}, $orig->{height} ) = $img->Get( 'base-columns', 'base-rows' );
    $log->error('[error] ',$pic) if $pic;
    &resize($_);
    undef $img;
  } @out;
  $log->info('[info] end start');
}

sub get_params {
  my $ind = 0;
  map {
    $log->info('[info] Get params for mini #'.($ind+1));
    my $p = $_;
    if ( $p =~ m/^--(.+?)(=(.+))?$/ ){
      my ( $name, $val ) = ( $1, $3 );
      $val =~ s/^'|'$//g;
      $out[$ind]->{$name} = $val;
      $log->info("[info] $name: $val");
      $ind += 1 if $name eq 'size';
    }
  } @ARGV;
}

sub go {
  my ( $opt ) = @_;
  $log->info('[info] start go');
  if ( $opt->{quality} ){
    $log->info('[info] Set quality: ',$opt->{quality});
    $dbg = $img->Set( quality => $opt->{quality} );
    $log->info('[info] ok');
    $log->error('[error] Set quality ',$dbg) if $dbg;
  }
  
  if ( !$opt->{orig} ){
    $log->info('[info] resize image '.$opt->{resize});
    if ( $opt->{type} && $opt->{type} eq 'adaptive' ){
      $dbg = $img->Adaptive( $opt->{resize} );
      $log->error('[error] Adaptive:',$dbg) if $dbg;
    }
    else {
      $dbg = $img->Resize( $opt->{resize} );
      $log->error('[error] Resize:',$dbg) if $dbg;
    }
  }
  else{
    $log->info('[info] Not resized');
  }

#  my ( $tmp_w , $tmp_h ) = ($img->Get('width'),$img->Get('height'));
#  $log->info('[info] tw: '.$tmp_w.', th: '.$tmp_h);
#  $tmp_w = $orig->{width} unless $tmp_w;
#  $tmp_h = $orig->{height} unless $tmp_h;
#  my $g = $tmp_w;
#  $g .= 'x';
#  $g .= $tmp_h;
#  $log->info('[info] New img SIZE: ',$g) if !$opt->{orig};
  if ( $opt->{crop} && ( $orig->{width} > $opt->{crop_x} && $orig->{height} > $opt->{crop_y} ) ){
    $log->info('[info] Crop image from '.$orig->{width}.'x'.$orig->{height}.' to '.$opt->{crop});
    $dbg = $img->Crop( geometry => $opt->{crop} . $opt->{xypos}, gravity => $opt->{gravity} );
    $log->error('[error] Crop:',$dbg) if $dbg;
  }
  
  if ( $opt->{wm} && $opt->{wm} == 1 && $project_id ) {
    $log->info('[info] need WM');
    my $wm_file = qq{$project_files/project_$project_id/const_watermark.png};

    if ( $opt->{wmfile} ) { 
        $wm_file = qq{$project_files/project_$project_id/const_$opt->{wmfile}.png};
    }
    if ( -f $wm_file ){
      my $watermark = Image::Magick->new;
      $log->info('[INFO] wmfile: ', $wm_file);
      my $wm = $watermark->Read($wm_file);
      $log->error('[error] Read WM ',$wm) if $wm;

      my ( $wm_width, $wm_height ) = $watermark->Get( 'base-columns', 'base-rows' );

      if ( $opt->{wmresize} ){
        $log->info('[info] Resize WM');
        $dbg = $watermark->Resize( geometry => $opt->{wmresize} );
        $log->error('[error] Resize WM ',$dbg) if $dbg;
      }

      $opt->{wmpos} = 'Center' unless $opt->{wmpos};
      $opt->{wmx} = 0 unless $opt->{wmx};
      $opt->{wmy} = 0 unless $opt->{wmy};

      if ( $orig->{width} > $wm_width ){ 
        $log->info('[info] Composite WM');
        $dbg = $img->Composite( image => $watermark, compose => 'Over', gravity => $opt->{wmpos}, x => $opt->{wmx}, y => $opt->{wmy} );
        $log->error('[error] Composite WM:',$dbg) if $dbg;
      }
      else {
        $log->info('[INFO] WMRESIZE: ',$opt->{wmresize});
        if ( $opt->{wmresize} =~ /^(\d+)x(\d+)$/ ){
            my $wmr_width = $1;
            my $wmr_height = $2;
            if ( $wmr_width < $wm_width ){
                $wm_width = $wmr_width;
            }
            if ( $wmr_height < $wm_height ){
                $wm_height = $wmr_height;
            }            
        }
        else{
            my $wm_width_new = ( $wm_width - ( $wm_width - $orig->{width} ));
            my $wm_height_new =  $orig->{height} > $wm_height ? $wm_height : ( $wm_height - ( $wm_height - $orig->{height} ) );
            $opt->{wmresize} = sprintf('%dx%d',($wm_width_new,$wm_height_new));
            #$opt->{wmresize} = ( $wm_width - ( $wm_width - $orig->{width} )) . 'x' . ( $wm_height - ( $wm_height - $orig->{height} ));
        }
        $log->info('[INFO] SET WMRESIZE: ', $opt->{wmresize});
        $log->info('[info] Orig width < WM width');
        $dbg = $watermark->Resize( geometry => $opt->{wmresize} );        
        $log->error('[error] Resize WM:', $dbg) if $dbg;
        $dbg = $img->Composite( image => $watermark, compose => 'Over', gravity => $opt->{wmpos}, x => $opt->{wmx}, y => $opt->{wmy} );
        $log->error('[error] Composite WM: ', $dbg) if $dbg;
      }
    }
    else { 
        print "<b color='red'>Watermark not found!</b>"; 
        $log->error('[error] watermark not found!');
    }
    
    # Текст на водном знаке
    if ( $opt->{wmtext} ){
      $log->info('[info] Need WM Text');
      my $wm_tmp = &wm_text( $opt->{wmtext},
        ( $opt->{wmfsize} ? $opt->{wmfsize} : 20 ),
        ( $opt->{wmfcolor1} ? $opt->{wmfcolor1} : 1),
        ( $opt->{wmfcolor2} ? $opt->{wmfcolor2} : 2),
        ( $opt->{sigma} ? $opt->{sigma} : 6 ),
        ( $opt->{radius} ? $opt->{radius} : 0 ),
      );
      my $wmf = qq{$project_files/project_$project_id/tmpwm.png};
      $log->info('[info] Save TMP WM');
      $dbg = $wm_tmp->Write( $wmf );
      $log->error('[error] Write TMP WM',$dbg) if $dbg;
      
      $log->info('[info] Read TMP WM');
      my $wm = Image::Magick->new();
      $dbg = $wm->ReadImage( $wmf );
      $log->error('[error] Read TMP WM',$dbg) if $dbg;
      my $degress = $opt->{wmdeg} ? $opt->{wmdeg} : -45;
      $wm->Rotate( degrees => $degress, background => 'rgba( 0, 0, 0, 0.0)' );
      
      my ( $h, $w ) = $img->Get('height','width');
      my ( $wm_h, $wm_w ) = $wm->Get('height','width');
      my $cheight = ( $h > $wm_h ? $h : $wm_h );
      my $cwidth = ( $w > $wm_w ? $w : $wm_w );
      
      $log->info("[info] new image CImg ${cwidth}x${cheight}");
      my $c = Image::Magick->new( size => "${cwidth}x${cheight}" );
      $dbg = $c->Read('canvas:transparent');
      $log->error('[error] Read CImg',$dbg) if $dbg;
      
      $log->info("[info] new image TLImg ${cwidth}x${cheight}");
      my $tl = Image::Magick->new( size => "${cwidth}x${cheight}" );
      $dbg = $tl->Read('canvas:transparent');
      $log->error('[error] Read TLImg',$dbg) if $dbg;

      my $cols = ceil( $w / $wm_w );
      my $rows = ceil( $h / $wm_h );
      
      $cols++ if $cols % 2 == 0;
      $rows++ if $rows % 2 == 0;
      
      my $center_col = ceil( $cols / 2 );
      my $center_row = ceil( $rows / 2 );
 
      my $cx = ( $w - $wm_w ) * 0.5;
      my $cy = ( $h - $wm_h ) * 0.5;

      for my $col ( 1 .. $cols ){
        for my $row ( 1 .. $rows ){
          my $x = $cx + ( $col - $center_col ) * $wm_w;
          my $y = $cy + ( $row - $center_row ) * $wm_h;
          $log->info("[info] Composite col: $col, row: $row");
          $dbg = $tl->Composite(
            image => $wm,
            compose => 'over',
            x => $x,
            y => $y,
            gravity => 'NorthWest',
          );
          $log->error('[error] Composite col && row ',$dbg) if $dbg;
        }
      }

      $log->info('[info] Composite 1');
      $c->Composite(
        image => $img, compose => 'over', gravity => 'center',
      );
      
      $log->info('[info] Composite 2');
      $c->Composite(
        image => $tl, compose => 'over', gravity => 'center',
      );
      
      $log->info('[info] Crop WM');
      $c->Crop(
        x => ( $cwidth - $w ) * 0.5,
        y => ( $cheight - $h ) * 0.5,
        width => $w,
        height => $h,
      );
      $img = $c;
      unlink $project_files.'/project_'.$project_id.'/tmpwm.png';
    }    
  }
  $log->info('[info] Save ',$opt->{dst});
  $dbg = $img->Write( $opt->{dst} );
  chmod 0664, $opt->{dst};
  $log->error('[error] Write ',$dbg) if $dbg;
  $log->info('[info] End go');
#  1;
}

sub wm_text {
  my($text,$fsize,$color1,$color2,$sigma,$radius) = @_;
  $log->info('[info] start wm_text');
  $text = 'WaterMarkText' unless($text);
  my $font = 'Bookman-Demi';
  my $font_size = $fsize ? $fsize : 20;
  my $geom='+'.($font_size*2).'+'.($font_size*2);
  my $kerning = 3;
  $sigma = 6 unless($sigma);
  $radius = 0 unless($radius);

  $color1 = '0,0,0' unless($color1 =~ m/^(\d+),(\d+),(\d+)$/);
  $color2 = '255,255,255' unless($color2 =~ m/^(\d+),(\d+),(\d+)$/);
  my $img = Image::Magick->new(size=>'1000x70');
  $dbg = $img->ReadImage('canvas:transparent');
  $log->error('[error] ReadImage',$dbg) if $dbg;

  $img->Annotate(
    text => $text,
    geometry => $geom, #"+50+50",
    pen => $img->QueryColorname('rgba('.$color1.',0.3)'),
    font => $font,
    pointsize => $font_size,
    kerning => $kerning,
  );

  $img->Blur(
    radius => $radius,
    sigma => $sigma,
    channel => 'RGBA',
  );

  my $mask = Image::Magick->new(size=>'1000x70');
  $mask->ReadImage('canvas:transparent');
  $mask->Annotate(
    text => $text,
    geometry => $geom, #"+50+50",
    pen => $img->QueryColorname('rgba('.$color2.',1)'),
    font => $font,
    pointsize => $font_size,
    kerning => $kerning,
  );

  $img->Composite(
    image => $mask,
    mask => $mask,
    compose => 'Clear',
  );

  $img->Annotate(
    text => $text,
    geometry => $geom, #"+50+50",
    pen => $img->QueryColorname('rgba('.$color2.',0.3)'),
    font => $font,
    pointsize => $font_size,
    kerning => $kerning,
  );

  $img->Trim();

  return $img;
}

