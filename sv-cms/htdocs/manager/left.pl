#!/usr/bin/perl
use DBI;
use CGI qw(:standard);
use CGI::Carp qw(fatalsToBrowser);
use Data::Dumper;
use Template;

print "Content-type: text/html; charset=windows-1251\n\n";
do './connect';

#/*******************************************************#


my $params;
$params->{template_name} = 'leftside_admin.tmpl';
$params->{project}->{template_folder} = $CMSpath.'/manager/templates/';
my $_____options;


#/******************************************************/#

our $dbh = DBI->connect("DBI:mysql:$DBname:$DBhost",$DBuser,$DBpassword, , { RaiseError => 1 }) || die($!);
$dbh->do("SET names CP1251");
# узнаём, кто он, что он...
my $sth=$dbh->prepare('SELECT manager_id,full_access from manager where login=?');
$sth->execute($ENV{REMOTE_USER});
my $manager=$sth->fetchrow_hashref();

my $host=$ENV{HTTP_HOST}; $host=~s{^www\.}{}i;
$manager->{project_id}=get_project_id(
  domain=>$host,
  connect=>$dbh,
  manager_id=>$manager->{manager_id},
  full_access=>$manager->{full_access}
);
unless($manager->{project_id}){
    print_header;
    print "внутренняя ошибка авторизации";
    exit;
}

#$sth=$dbh->prepare(qq{
#	SELECT m.header, m.url, i.photo FROM manager_menu m
#	LEFT join manager_menu_icons i ON (i.id=m.photo_id)
#	where m.manager_id = ? order by sort
#	});
#$sth->execute($manager->{manager_id});

# 1. Проверяем, есть ли информация о собственном меню
#if($sth->rows())
if(0){
	my $addons;
	
	while(my $item=$sth->fetchrow_hashref){
		if($item->{photo}){
			$addons.=qq{<a href="$item->{url}"><img src="./menu_icons/$item->{photo}" target="main"/></a><br>};
		}
		$addons.=qq{<b><a href="$item->{url}" target="main">$item->{header}</a><br></b><br>}
	}
	
	$content=qq{
		<div class="head">&nbsp;</div>
		<div style="padding-left: 20px; line-height: 20px; text-align: center;">
		$addons		
		</div>
		
	};
}
else{
	# Проверяем, привязан ли проект к типовому шаблону?
	$sth=$dbh->prepare("SELECT options from project_group_site where project_id=?");
	$sth->execute($manager->{project_id});

	if(my $options=$sth->fetchrow()){
	my $out='<li><a href="./change_promoblock.pl" target="main">Выбрать промо-блок</a></li>';	
		# Обозначаем соответствие опции и инструмента
		$keys={
			service_promo=>['admin_table.pl?config=promo','Promo'],
			service_searchfiles=>['./admin_table.pl?config=files','Файлы для поисковиков'],
			service_const=>['./template_const.pl','Константы'],
			service_text_page=>['admin_table.pl?config=content','Текстовые страницы'],
			service_top_menu=>['./admin_tree.pl?config=top_menu_tree','Верхнее меню'],
			service_bottom_menu=>['./admin_tree.pl?config=bottom_menu','Нижнее меню'],
			service_news=>['admin_table.pl?config=news_ct1','Новости'],
			service_articles=>['admin_table.pl?config=articles_ct1','Статьи'],
			service_goodkat=>[
				'admin_tree.pl?config=rubricator_ct1','Рубрикатор товаров',
				'admin_tree_move.pl?config=rubricator_ct1','Перемещение рубрик',
				'admin_table.pl?config=good_ct1','Товары',
				'pxls/pxls.pl','Парсер XLS',
				'fast_load_photo_good.pl?action=start','Быстрая загрузка фото для товаров',
			],
			service_service=>['admin_tree.pl?config=service_rubricator_ct1','Услуги'],
			
		};
		$options.=';service_searchfiles;';
		while($options=~m/;([^;]+);/gs){
			my $o=$1;
			my $i=0;
			while($i<scalar(@{$keys->{$o}})){
				my $url=$keys->{$o}->[$i];
				my $description=$keys->{$o}->[$i+1];
				$out.=qq{<li><a href="$url" target="main">$description</a></li>};
				$i+=2;
			}
			#foreach my ($link,$description) = ($keys->{$o}){
			#	print "$link ; $description<br/>";
			#}
		}
		
		$content=qq{
					<div class="head">Разделы сайта</div>
						<ul class="spec list9">
							$out
						</ul>	
				};

	}
	else{
		
		
		#/************************************************
		#/* Получаем опции проекта
		#/* Ну вы знаете если что кого бить. Антонов.
		
		my $addons;
		
				#Добавляем в вывод дополнительый парсер CSV
				$sth=$dbh->prepare('SELECT options from project where project_id=?');
				$sth->execute($manager->{project_id});
				
				$_____options = $sth->fetchrow();
				
				
		
		#/************************************************
		#/* Функционал новой графической админки
		if ( $_____options =~ /new_client_backend_style/ ) {
			
			$params->{TMPL_VARS}->{STANDART} = $dbh->selectall_arrayref("select header,link FROM struct_public, project_struct_public WHERE struct_public.struct_public_id=project_struct_public.struct_public_id and project_struct_public.project_id=$manager->{project_id}", {Slice=>{}});
				
			#Загрузим иконки для последующего внедрения
			#  
			#У сервиса иконка может быть:
			#	1. из группы (типа)
			#	2. своя собственная
			#
			# Потом сервис группы сервисов будет использоваться так же для сортировки вывода сервисов
			
				my $icons = $dbh->selectall_hashref("SELECT  *, id as id, concat('/files/project_3306/icons/',photo) as photo_and_path , concat('/files/project_3306/icons/',substring_index(photo,'.',1),'_mini1','.',substring_index(photo,'.',-1)) as photo_and_path_mini1 , concat('/files/project_3306/icons/',substring_index(photo,'.',1),'_mini2','.',substring_index(photo,'.',-1)) as photo_and_path_mini2 , concat('/files/project_3306/icons/',substring_index(photo,'.',1),'_mini3','.',substring_index(photo,'.',-1)) as photo_and_path_mini3 FROM struct_icons", "id");
				my $groups = $dbh->selectall_hashref("SELECT  *, rubricator_id as id, concat('/files/project_3306/types_icons/',photo) as photo_and_path , concat('/files/project_3306/types_icons/',substring_index(photo,'.',1),'_mini1','.',substring_index(photo,'.',-1)) as photo_and_path_mini1 , concat('/files/project_3306/types_icons/',substring_index(photo,'.',1),'_mini2','.',substring_index(photo,'.',-1)) as photo_and_path_mini2 , concat('/files/project_3306/types_icons/',substring_index(photo,'.',1),'_mini3','.',substring_index(photo,'.',-1)) as photo_and_path_mini3 FROM struct_groups WHERE path='' ", "rubricator_id");
				
				
#				print "SELECT  *, rubricator_id as id, concat('/files/project_3306/types_icons/',photo) as photo_and_path , concat('/files/project_3306/types_icons/',substring_index(photo,'.',1),'_mini1','.',substring_index(photo,'.',-1)) as photo_and_path_mini1 , concat('/files/project_3306/types_icons/',substring_index(photo,'.',1),'_mini2','.',substring_index(photo,'.',-1)) as photo_and_path_mini2 , concat('/files/project_3306/types_icons/',substring_index(photo,'.',1),'_mini3','.',substring_index(photo,'.',-1)) as photo_and_path_mini3 FROM struct_groups WHERE project_id=$manager->{project_id}";
				
				$$params{TMPL_VARS}{ICONS} = $icons;
				$$params{TMPL_VARS}{GROUPS} = $groups;
				
				
				# смотрим, какие доп. таблицы админятся в этом проекте
				$params->{TMPL_VARS}->{ADDONS} = $dbh->selectall_arrayref("SELECT struct_id,header,admin_script, struct_type, struct_icon as struct_icon_id from struct where project_id=$manager->{project_id} and enabled order by header", {Slice=>{}});

				foreach ( @{ $$params{TMPL_VARS}{ADDONS} } ) {
					#$_->{struct_icon} = $cons->{struct_icon_id}->{photo_and_path};
				}
				
				#/*********************************************************
				
				if ( $_____options =~ /promo_loader/  ) {					
					#$addons.=qq{<li><a href="./parser_scripts/$$manager{project_id}.pl?project_id=$$manager{project_id}" target="main"><b>Парсер CSV</b></a></li>};
					$addons.=qq{<li><a href="./promo_parser_dev.pl?project_id=$$manager{project_id}" target="main"><b>Загрузить promo из XLS</b></a></li>};
				}
				if ( $options =~ /redirect_loader/ ){
					$addons.=qq{<li><a href="./redirect_parser_dev.pl?project_id=$$manager{project_id}" target="main"><b>Загрузить Редиректы</b></a></li>};
				}
				
				
				#/*********************************************************
				
				if ( $_____options =~ /goods_pic_loader/  ) {					
					#$addons.=qq{<li><a href="./parser_scripts/$$manager{project_id}.pl?project_id=$$manager{project_id}" target="main"><b>Парсер CSV</b></a></li>};
					$addons.=qq{<li><a href="./artikulTools.pl?project_id=$$manager{project_id}" target="main"><b>Загрузить фото по артикулу</b></a></li>};
				}
				
				#/*********************************************************
				
				if ( $_____options =~ /use_csv_parser_uploader/  ) {					
					#$addons.=qq{<li><a href="./parser_scripts/$$manager{project_id}.pl?project_id=$$manager{project_id}" target="main"><b>Парсер CSV</b></a></li>};
					$addons.=qq{<li><a href="./parserConnector.pl?project_id=$$manager{project_id}&type=csv" target="main"><b>Парсер CSV</b></a></li>};
				}
			
				if ( $_____options =~ /use_xml_parser_uploader/  ) {
					$addons.=qq{<li><a href="./parserConnector.pl?project_id=$$manager{project_id}&type=xml" target="main"><b>Парсер XML</b></a></li>};
				}
			
				#/**********************************************************
				
				# Если существуют парсеры -- выводим и их:
				$sth=$dbh->prepare('SELECT id,header from pxls where project_id=?');
				$sth->execute($manager->{project_id});

				while(my ($id,$header)=$sth->fetchrow()){
					$addons.=qq{<li><a href="./pxls/pxls.pl?config_id=$id" target="main">$header</a></li>}
				}
				
				#/*********************************************************
				$addons.=qq{!!!!};
				
			
		}
		else {
		#/************************************************
		#/* Функционал стандартной админки
				
		
				# Какие стандартные таблицы показываем?
				$sth=$dbh->prepare('select header,link FROM struct_public, project_struct_public WHERE struct_public.struct_public_id=project_struct_public.struct_public_id and project_struct_public.project_id=?');
				$sth->execute($manager->{project_id});
				my $standart='';
				while(my ($header,$link)=$sth->fetchrow()){
					$standart.=qq{<li><a href="$link" target="main">$header</a></li>}
				}

				# смотрим, какие доп. таблицы админятся в этом проекте
				#my $addons='';
				$sth=$dbh->prepare('SELECT struct_id,header,admin_script from struct where project_id=? and enabled order by header');
				$sth->execute($manager->{project_id});
				while(my ($struct_id,$header,$admin_script)=$sth->fetchrow()){
					$addons.=qq{<li><a href="./$admin_script?config=$struct_id" target="main">$header</a>};
					if($admin_script eq 'admin_tree.pl'){
							$addons.=qq{<br><i><span class="f-10 gray"><a href="./admin_tree_move.pl?config=$struct_id" target="main">(перемещение)</a></span></i></br>}
					}
					$addons.=q{</li>}
				}
				#/********************************************************

				if ( $_____options =~ /url_generator/ ){
					$addons.=qq{<li><a href="/manager/generator_url.pl?pid=$$manager{project_id}" target="main"><b>Генерация ЧПУ</b></li>};
				}
				if ( $_____options =~ /ecom/ ){
					$addons.=qq{<li><a href="/manager/ecom.pl?pid=$$manager{project_id}" target="main"><b>E-commerce</b></a></li>};
				}
				
				#/*********************************************************
				
				if ( $_____options =~ /promo_loader/  ) {					
					#$addons.=qq{<li><a href="./parser_scripts/$$manager{project_id}.pl?project_id=$$manager{project_id}" target="main"><b>Парсер CSV</b></a></li>};
					$addons.=qq{<li><a href="./promo_parser_dev.pl?project_id=$$manager{project_id}" target="main"><b>Загрузить promo из XLS</b></a></li>};
				}
				if ( $_____options =~ /redirect_loader/ ){
					$addons.=qq{<li><a href="./redirect_parser_dev.pl?project_id=$$manager{project_id}" target="main"><b>Загрузка Редиректов</b></a></li>};
				}
				
				
				
				#/*********************************************************
				
				if ( $_____options =~ /goods_pic_loader/  ) {					
					#$addons.=qq{<li><a href="./parser_scripts/$$manager{project_id}.pl?project_id=$$manager{project_id}" target="main"><b>Парсер CSV</b></a></li>};
					$addons.=qq{<li><a href="./artikulTools.pl?project_id=$$manager{project_id}" target="main"><b>Загрузить фото по артикулу</b></a></li>};
				}
				
				#/*********************************************************

				if ( $_____options =~ /use_csv_parser_uploader/  ) {
					#$addons.=qq{<li><a href="./parser_scripts/$$manager{project_id}.pl?project_id=$$manager{project_id}" target="main"><b>Парсер CSV</b></a></li>};
					$addons.=qq{<li><a href="./parserConnector.pl?project_id=$$manager{project_id}&type=csv" target="main"><b>Парсер CSV</b></a></li>};
				}
				
				if ( $_____options =~ /use_xml_parser_uploader/  ) {
					#$addons.=qq{<li><a href="./parser_scripts/$$manager{project_id}.pl?project_id=$$manager{project_id}" target="main"><b>Парсер CSV</b></a></li>};
					$addons.=qq{<li><a href="./parserConnector.pl?project_id=$$manager{project_id}&type=xml" target="main"><b>Парсер XML</b></a></li>};
				}
				
				# Если существуют парсеры -- выводим и их:
				$sth=$dbh->prepare('SELECT id,header from pxls where project_id=? and enabled=1');
				$sth->execute($manager->{project_id});

				while(my ($id,$header)=$sth->fetchrow()){
					$addons.=qq{<li><a href="./pxls/pxls.pl?config_id=$id" target="main">$header</a><br><a href="./pxls/gen_tmpl.pl?config_id=$id">(шаблон)</a></li>}
				}
				my $project_menu_list;
				eval {
					$sth=$dbh->prepare("select header,url from project_menu where project_id=? order by sort");
					$sth->execute($manager->{project_id});
					$project_menu_list=$sth->fetchall_arrayref({});
					if(scalar(@{$project_menu_list})){
						foreach my $m (@{$project_menu_list}){
							$addons.=qq{<li><a href="$m->{url}" target="main">$m->{header}</a></li>}
						}
					}
					

				};
				$url_generator=qq{<li><a href="./generator_url.pl?pid=$manager->{project_id}" target="main">Генератор ЧПУ (тест)</a></li>};
				$url_generator='' unless($manager->{project_id} == 4275);
				$exit_btn = '<li><b><a href="http://log:out@'.$ENV{HTTP_HOST}.'/manager/?action=logout" title="Выход" target="_top">Выход</a></b></li>';
				$content=qq{
					<div class="head">Функционал</div>
						<ul class="spec list9">
							$exit_btn
							$standart
							$url_generator
						</ul>	
						<div class="head">Разделы и сервисы</div>		
						<ul  class="spec list9">
							$addons		
					</ul>
				};
				
				
		}		
				
				
				
				
				
				
				
	}
}
if ( $_____options =~ /new_client_backend_style/ ) {

       eval(q{ 
        my $template = Template->new(
        {
            INCLUDE_PATH => $params->{project}->{template_folder},
            COMPILE_EXT => '.tt2',
            COMPILE_DIR=>$CMSpath.'/tmp',
            CACHE_SIZE => 512,
            PRE_CHOMP  => 1,
            POST_CHOMP => 1,
            DEBUG_ALL=>1,
            #EVAL_PERL=>1,
            FILTERS=>{
                get_url=>\&filter_get_url
            }
       
        });
        $template -> process($params->{template_name}, $params->{TMPL_VARS}) || croak "output::add_template: template error: ".$template->error();
        });
       
        if($@){
            print $@;
        }
	
}
else {
print qq{
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ru" lang="ru">
<head>
<meta http-equiv="content-type" content="text/html; charset=windows-1251" />
<meta http-equiv="description" content="" />
<meta http-equiv="keywords" content="" />
<title>Untitled Document</title>
<link href="css/style.css" rel="stylesheet" type="text/css" media="screen, projection" />
<!--// Незабываем прописывать и здесь путь к файлам и в файле ie.css  //-->
<!--[if lte IE 8]>
<link href="css/ie.css" rel="stylesheet" type="text/css" media="screen, projection" />
<script type="text/jscript" src="javascript/ie.pack.js"></script>
<![endif]-->
</head>
<body>
<style>
.top_links { padding-top: 5px; border-top: 1px solid gray}
.top_links li {list-style: none; padding: 5px}
.top_links a {color: rgb(2, 152, 202)/*#5a7d05 #384C67*/; text-decoration: none; font-weight: bold; }

::-webkit-scrollbar {
	-webkit-appearance: none;
	width: 7px;
	
}
::-webkit-scrollbar-thumb{
	border-radius: 2px;
	background-color: #384C6733;
	-webkit-box-shadow: 0 0 1px rgba(255,255,255,0.5);
}

</style>
<div class="wrapper">
	<div class="header" style="text-align: center;">
		<!--<div class="logo"><a href="http://www.designb2b.ru" target='_blank'>designb2b</a></div>-->
		<a href="./start.pl" target="main"><img src="./images/pic1.png"></a>
	</div>
	<div >
		<ul class="spec list9">
			<li><a href="https://help.design-b2b.com" target="_blank" class="btn">Руководство пользователя</a></li>
			<li><a href="//$ENV{HTTP_HOST}" target="_blank" class="btn">Перейти на сайт</a></li>
		</ul>
	</div>
	$content
	<!-- $manager->{project_id} -->
	<div class="undfoot"></div>
	<div class="footer"></div>
</div>
</body>
</html>
};
}


sub get_project_id{
  my %arg=@_;
  my $sth=$arg{connect}->prepare('SELECT project_id FROM domain where domain=?');
  $sth->execute($arg{domain});
  my $project_id=$sth->fetchrow();

  unless($project_id){ # проект не найден
    return undef
  }

  if($arg{full_access}){
    return $project_id
  }
  else{
    my $sth=$arg{connect}->prepare(q{
      SELECT
        mpa.project_id
      FROM 
        manager_project_access mpa
        join domain d ON (d.project_id=mpa.project_id)
      WHERE 
        mpa.manager_id=? and mpa.project_id=?
    });
    $sth->execute($arg{manager_id},$project_id);
    return $sth->fetchrow;

  }
}