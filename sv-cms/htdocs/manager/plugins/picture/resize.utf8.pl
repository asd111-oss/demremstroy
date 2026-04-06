#!/usr/bin/perl
use strict;
use warnings;
use Image::Magick;
use Data::Dumper;
use POSIX qw/ceil/;

our @out = ();
our $in;
our $img;
our $pic;
our $pic_o;
our $orig;
our $project_id;
our $project_files = '/www/sv-cms/htdocs/files';

&init;

sub init {
  if ( scalar @ARGV > 0 ){
    $in->{file} = $ARGV[0];
    if ( $in->{file} =~ m/^(.+)\.(.*?)$/ ){
      $in->{name} = $1;
      $in->{ext} = $2;
    }
    &get_params;
    &start;
  }
  else {
    print "Error! Not found options";
    exit;
  }
}

sub resize {
  my ( $opt ) = @_;
  if ( $opt->{project_id} ) { $project_id = $opt->{project_id}; }
  # Если указан выходной файл
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
      if ( 
        ( $opt->{width} != 0 && $opt->{height} != 0 ) ||      
        ( $opt->{width} == 0 && $orig->{height} >= $opt->{height} ) ||
        ( $opt->{height} == 0 && $orig->{width} >= $opt->{width} ) 
      ){
        $opt->{orig} = undef;
      }
      else { $opt->{orig} = 1; }
    }

    &go($opt);
  }
}

sub start {
  $img = Image::Magick->new;
  $pic_o = $img->Read($in->{file});

  ( $orig->{width}, $orig->{height} ) = $img->Get( 'base-columns', 'base-rows' );
  map {
    $pic = $img->Clone();
    my $row = $_;
    my $opt;
#    map {
#      my $key = $_;
#      $opt->{$key} = $row->{$key};
#    } keys $row;
    &resize($row);
  } @out;
}

sub set_param {
  my ( $name, $val, $ind ) = @_;
  $out[$ind]->{$name} = $val;
}

sub get_params {
  my $ind = 0;
  map {
    my $p = $_;
    if ( $p =~ m/^--(.+?)(=(.+))?$/ ){
      my ( $name, $val ) = ( $1, $3 );
      $val =~ s/^'|'$//g;
      &set_param( $name, $val, $ind);
      $ind += 1 if $name eq 'size';
    }
  } @ARGV;
}

sub err {
  my ( $code ) = @_;
  if ( !$code ) {
    print "ERROR!!! Не хватает входных данных\n";
  }
  elsif ( $code ){
    print "$code\n";
  }
  exit;
}

sub go {
  my ( $opt ) = @_;

  if ( $opt->{quality} ){
    $pic->Set( quality => $opt->{quality} );
  }
  
  if ( !$opt->{orig} ){
    if ( $opt->{type} && $opt->{type} eq 'adaptive' ){
      $pic->Adaptive( $opt->{resize} );
    }
    else {
      $pic->Resize( $opt->{resize} );
    }
  }
  
  if ( $opt->{crop} && ( $orig->{width} > $opt->{crop_x} && $orig->{height} > $opt->{crop_y} ) ){
    $pic->Crop( geometry => $opt->{crop} . $opt->{xypos}, gravity => $opt->{gravity} );
  }
  
  if ( $opt->{wm} && $opt->{wm} == 1 && $project_id ) {
    my $wm_file = qq{$project_files/project_$project_id/const_watermark.png};
    if ( $opt->{wmfile} ) { $wm_file = qq{$project_files/project_$project_id/const_$opt->{wmfile}.png}; }
    if ( -f $wm_file ){
      my $watermark = Image::Magick->new;
      my $wm = $watermark->Read($wm_file);
      my ( $wm_width, $wm_height ) = $watermark->Get( 'base-columns', 'base-rows' );
      $watermark->Resize( geometry => $opt->{wmresize} ) if $opt->{wmresize};
      $opt->{wmpos} = 'Center' unless $opt->{wmpos};
      $opt->{wmx} = 0 unless $opt->{wmx};
      $opt->{wmy} = 0 unless $opt->{wmy};
      if ( $orig->{width} > $wm_width ){ 
        $img->Composite( image => $watermark, compose => 'Over', gravity => $opt->{wmpos}, x => $opt->{wmx}, y => $opt->{wmy} );
      }
      else {
        $opt->{wmresize} = $opt->{wmresize} ? $opt->{wmresize} : ( $wm_width - ( $wm_width - $orig->{width} )) . 'x' . ( $wm_height - ( $wm_height - $orig->{height} ));
      }
    }
    else { print "<b color='red'>Watermark not found!</b>"; }
    
    # Текст на водном знаке
    if ( $opt->{wmtext} ){
      my $wm_tmp = &wm_text( $opt->{wmtext},
        ( $opt->{wmfsize} ? $opt->{wmfsize} : 20 ),
        ( $opt->{wmfcolor1} ? $opt->{wmfcolor1} : 1),
        ( $opt->{wmfcolor2} ? $opt->{wmfcolor2} : 2),
        ( $opt->{sigma} ? $opt->{sigma} : 6 ),
        ( $opt->{radius} ? $opt->{radius} : 0 ),
      );
      my $wmf = qq{$project_files/project_$project_id/tmpwm.png};
      $wm_tmp->Write( $wmf );
      my $wm = Image::Magick->new();
      $wm->ReadImage( $wmf );
      my $degress = $opt->{wmdeg} ? $opt->{wmdeg} : -45;
      $wm->Rotate( degrees => $degress, background => 'rgba( 0, 0, 0, 0.0)' );
      
      my ( $h, $w ) = $img->Get('height','width');
      my ( $wm_h, $wm_w ) = $wm->Get('height','width');
      my $cheight = ( $h > $wm_h ? $h : $wm_h );
      my $cwidth = ( $w > $wm_w ? $w : $wm_w );
      
      my $c = Image::Magick->new( size => "${cwidth}x${cheight}" );
      $c->Read('canvas:transparent');
      
      my $tl = Image::Magick->new( size => "${cwidth}x${cheight}" );
      $tl->Read('canvas:transparent');

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
          $tl->Composite(
            image => $wm,
            compose => 'over',
            x => $x,
            y => $y,
            gravity => 'NorthWest',
          );
        }
      }

      $c->Composite(
        image => $pic, compose => 'over', gravity => 'center',
      );
      
      $c->Composite(
        image => $tl, compose => 'over', gravity => 'center',
      );
      
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
  $pic->Write( $opt->{dst} );
  # 1;
}

sub wm_text {
  my($text,$fsize,$color1,$color2,$sigma,$radius) = @_;
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
  $img->ReadImage('canvas:transparent');

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

