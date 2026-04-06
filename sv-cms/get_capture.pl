#!/usr/bin/perl
use Image::Magick;
use GD;
use CGI::Carp qw/fatalsToBrowser/;
use CGI::Fast qw(:standard);
use Data::Dumper;
use strict;
#use warnings;
#use lib '/www/sv-cms/htdocs/lib';
use lib './lib';
use appdbh;

our $pid;
#our @ua = ('Google','Yandex');

while (new CGI::Fast) {
	my $dbh = appdbh->new;
        my $head_robot;
	if ( lc($ENV{HTTP_USER_AGENT}) =~ /(google|yandex|bot)/ ){ 
          $head_robot = '<head><meta name="robot" value="noindex, nofollow"/></head>';
        }

	my $action=param('action');	

	my $domain=$ENV{SERVER_NAME};
	$domain=~s/^www\.//;
	
	my $sth=$dbh->prepare("SELECT project_id from domain WHERE domain=?");
	$sth->execute($domain);

	my $project_id=$sth->fetchrow();
	$pid = $project_id;

	unless($project_id){
		print header(-type=>'text/html',-status=>404);
		print "project_id not found";
		exit;
	}

	my $opt=&get_options({ dbh=>$dbh, project_id=>$project_id });
	my $qs=$ENV{QUERY_STRING};
	$qs=~s/action=.+?&?//;
	if($action eq 'refrash'){
		# если делается refrash, нужно проверить, генерировался ли код ранее:
		my $str_key=param('str_key');
		my $sth=$dbh->prepare("SELECT count(*) from capture where str_key=?");
		$sth->execute($str_key);
		if($sth->fetchrow()){
			#$dbh->do("DELETE from capture where str_key='$str_key'");			
		}
		else{
			print header(-type=>'text/html', -charset=>'windows-1251',-status=>500);
			print "попытка подмены?";
			exit;
		}
	}
	if($action eq 'out_key' || $action eq 'refrash'){
		my $status = defined $head_robot && $head_robot ne '' ? 403 : 200;
  		print header(-type=>'text/html',-status=>$status,-X_Robots_Tag=>'noindex');
		# получаем случайную строку и ключ для неё
		
		my $str;
		my $str_res;
		if(  $opt->{method}==1 ){ # вывод примера
			
			$opt->{chars_count}=2 unless($opt->{chars_count});
			$str=$str_res=&gen_example($opt->{chars_count});
			eval('$str_res=('.$str.')');
#			if ($@) { } 
			$str.='=';
		}
		else{ # вывод цифр
			$opt->{chars_count}=5 unless($opt->{chars_count});
			$str=$str_res=&gen_str($opt->{chars_count});
			
		}
		
		my $sth=$dbh->prepare('select md5(?)');
		$sth->execute($str_res);
		my $str_key=$sth->fetchrow();
		# сохраняем информацию о строки и ключе в БД
		$sth=$dbh->prepare("INSERT INTO capture(str,str_key,registered,project_id) values(?,?,now(),?)");
		$sth->execute($str,$str_key,$project_id);
		
		# генерируем ключ для cpan'а с капчей (ведь на странице капч может быть несколько)

		if($action eq 'refrash'){
			my $cpt_id=param('cpt_id');
			print $head_robot if $head_robot;
			print qq{<input type='hidden' name='capture_key' value='$str_key'><a href="#" onclick="javascript: document.getElementById('$cpt_id').innerHTML=loadDocAsync('/get_capture.pl?action=refrash&cpt_id=$cpt_id&str_key=$str_key&$qs&$opt->{params}');return false"><img class="capture" align='absmiddle' src='/get_capture.pl?action=out_capture&key=$str_key&$qs&$opt->{params}'></a>};
		}
		else{
			my $cpt_p=param('cpt_id');
			$cpt_p='cpt' unless($cpt_p);
			my $cpt_id=$cpt_p.&gen_str(5);
			print $head_robot if $head_robot;
			my $img_and_hidden=qq{<input type='hidden' name='capture_key' value='$str_key'><a href="#" onclick="javascript: document.getElementById('$cpt_id').innerHTML=loadDocAsync('/get_capture.pl?action=refrash&cpt_id=$cpt_id&str_key=$str_key&$qs&$opt->{params}');return false"><img class="capture" align='absmiddle' src='/get_capture.pl?action=out_capture&key=$str_key&cpt_id=$cpt_id&$qs&$opt->{params}'></a>};
			print qq{<span id='$cpt_id'>$img_and_hidden</span>};
		}
	}	
	elsif($action eq 'out_capture'){		
		my $key=param('key');
		my $sth=$dbh->prepare("SELECT str from capture where project_id=? and str_key=?");
		$sth->execute($project_id,$key);
		my $str=$sth->fetchrow();
		&out_capture($str,$opt);
		exit;
	}
	else{
		print header(-type=>'text/html',-status=>404);
		print "Params not found...";
		exit;
	}

}

sub gen_str{
	my $count=shift;
	my $a=q{123456789abcdefghijklmnopqrstuvwxyz};		
	my $str='';
	foreach my $k (1..$count){
		$str.=substr($a,int(rand(length($a))),1)
	}
	return $str;
}

sub gen_example{
	my $count=shift;
	my $a=q{123456789};
	my $x1='';
 	my $x2='';
        map {
		$x1.=substr($a,int(rand(length($a))),1);
		$x2.=substr($a,int(rand(length($a))),1);
	} (1..$count);
	return qq{$x1+$x2};
}

sub gen_num {
	my $in = @_;
	my $n = q{123456789};
	my $result = '';
	foreach my $k (1..$in){
		$result .= substr($a,int(rand(length($a))),1);
	}
	return $result;
}

sub out_capture{
  my $cap_string = shift;

  my $font = q{./lib/capcha.ttf};
#exit;
=cut
  my $im = new GD::Image(230,80);
  my $white = $im->colorAllocate(255,255,255);
  my $black = $im->colorAllocate(0,0,0);
  $im->transparent($white);
  $im->interlaced('true');
  $im->rectangle(0,0,229,79,$black);
  $im->stringFT($black,$font,42,0,50,56,$cap_string);
  print header(-type=>'image/png',-status=>200);
  binmode STDOUT;  
  print $im->png;
  exit;
=cut

  my $opt=shift;
  my $dbg;
  my $font = q{./lib/capcha.ttf};

  my $image = new Image::Magick;
  
  # 1. Создаём поле 300x100 белого цвета.
  $dbg = $image->Set(size => ($opt->{width}*3).'x'.($opt->{height}*2));

  $dbg = $image->ReadImage('xc:'.$opt->{background});

  # 2. Печатаем черным с антиалиасингом
  $dbg = $image->Set(
			type 		=> 'TrueColor',
			antialias	=>	'True',
			fill		=>	$opt->{color},
			font		=>	$font,
			pointsize	=>	$opt->{fontsize},
			);

  $dbg = $image->Draw(
			primitive	=>	"text",
			points		=>	"20,75", # ориентация строки текста внутри картинки
			text		=>	"$cap_string", # что печатаем
			);

  # 3. Подвинуть центр влево на 100 точек +случайная флуктуация
  $dbg = $image->Extent(
			geometry	=>	'400x120', # меняем размер картинки
			);
  
  $dbg = $image->Roll(
			x			=>	101#+int(rand(4)),
			);
  
  # 4. Первый swirl на случайный угол (от 37 до 51)
  $dbg = $image->Swirl(
			degrees		=>	(rand($opt->{deg2_to}))+$opt->{deg2_from} #37,
			);
  
  # 5. Подвинуть центр вправо на 200 точек, тоже со случайной флуктуацией
  $dbg = $image->Extent(
			geometry	=>	'600x140', # меняем размер картинки
			);
  
  $dbg = $image->Roll(
			x			=>	3#-int(rand(4)),
			);

  # 6. Второй поворот (от 20 до 35)
  $dbg = $image->Swirl(
			degrees		=>	int(rand($opt->{deg1_to}))+$opt->{deg1_from},
			);

  # 7. Окончательная обработка и вывод
  $dbg = $image->Crop('230x80+110+7');

  $dbg = $image->Resize($opt->{width}.'x'.$opt->{height});

  #print header(-type=>'image/png',-status=>200);
  print "Content-type: image/png\n\n";
  binmode STDOUT; 
  $dbg = $image->Write('png:-'); 
#  $dbg = $image->Write('jpg:-');
}

sub get_options{
	my $par=shift;
	my $opt={
		width=>'150',
		height=>'50',
		deg1_from=>0,
		chars_count=>1,
		deg1_to=>0,#30,
		deg2_from=>0,
		deg2_to=>0,#30,
		background=>'#ffffff',
		color=>'#000000',
		fontsize=>'60',
		method=>'1', # 0 -- проверочная строка ; 1 -- пример
	};
	
	my $domain = $ENV{HTTP_HOST};
	$domain=~s/^www\.//;
	# считываем параметры
	
	my $sth=$par->{dbh}->prepare(q{
		SELECT cs.* 
		FROM project p, domain d, capture_setting cs 
		WHERE p.project_id = d.project_id and d.template_id=cs.template_id and d.domain = ?
	});
		
	$sth->execute($domain);
	my $opt_tmp=$sth->fetchrow_hashref();
	
	foreach my $attr (keys(%{$opt_tmp})){
		my $v=$opt_tmp->{$attr};
		my $p=param($attr);
		if($p=~m/^[a-zA-Z0-9#]+$/){ # проверяем параметр через http
			if($p=~m/^[a-f0-9]{6}$/i && ($attr eq 'color' || $attr eq 'background')){
				$p='#'.$p;
			}
			$opt->{$attr}=$p;
			print "value: $p";
		}
		elsif($v=~m/^[a-zA-Z0-9#]+$/){ # проверяем параметр из БД
			#$opt->{params}.=qq{&$attr=$v};
			if($v=~m/^[a-f0-9]{6}$/i && ($attr eq 'color' || $attr eq 'background')){
				$v='#'.$v;
			}
			$opt->{$attr}=$v;		
		}
	}
	return $opt;
}
