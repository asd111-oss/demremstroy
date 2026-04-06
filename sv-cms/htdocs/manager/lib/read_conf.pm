package read_conf;
use lib '.';
use DBI;
use CGI qw(:standard);
use CGI::Carp qw (fatalsToBrowser);
use Data::Dumper;
use auth;

BEGIN {
		use Exporter ();
		@ISA = "Exporter";
		@EXPORT = ('&read_config', '&connect','$dbh');
	}
use struct_admin;

#use Log::Any qw($log);
#use Log::Any::Adapter('File','/home/isavnin/log/edit.log');
#my $site = '['.$ENV{SERVER_NAME}.'][read_conf]';

# иногда возникает необходимость считывать код конфига для формы не из файла-конфига, а как-нибудь из БД, с проверкай юзверя и т.п.
# поэтому здесь прописывается правило для чтения и формирования конфига (его можно изменять так, как душе угодно).
# read_data($config)
sub read_config{
#	$log->info($site,' begin');
	my $cgi=new CGI;
	my $config=param('config');
    our $form; our %form;

	do './connect';
	my $dbh = DBI->connect("DBI:mysql:$DBname:$DBhost",$DBuser,$DBpassword, , { RaiseError => 1 }) || die($!);
	$dbh->do("SET NAMES CP1251"); 
	# конфиги общего назначения:
	my $already_read=0;
	
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
    my $domain=$ENV{HTTP_HOST}; $domain=~s{^www\.}{};
	 my $sth=$dbh->prepare("SELECT p.project_id,p.options,d.template_id,d.domain, d.server_type from project p join domain d ON (d.project_id=p.project_id)  WHERE d.domain=? and p.project_id=?");
	 $sth->execute($domain, $manager->{project_id});
	 my $project=$sth->fetchrow_hashref();
	#if(param('debug')){
    if($project->{server_type}==3){
        #print_header();
        my $url=$ENV{REQUEST_URI};
        $url=~s{^\/manager\/}{\/manager2\/};
        print_header();
        print
         qq{
            <script>location.href='$url'</script>
        };
        #print "Location: //$ENV{SERVER_NAME}$url\n\n";
        #pre(\%ENV);
        exit;
    }
        

    #}
	
	

	
	# список общих структур, кот. нужно сделать приватными:

	#print "config: $config<br/>";
	if($config=~m/^[a-zA-Z0-9\_]+$/ && -e qq{./conf/$config}){
			my $code = &read_file("./conf/$config");
			$code=~s/\[%project_id%\]/$project->{project_id}/gs;
			#print "code: $code<br/>";
			eval($code);
			print @$ if(@$);	
			$already_read=1;
	}
	$form=\%form;
    
	#$form{project}=$project;
	#$form{project_id}=$form{project}->{project_id};
	if(!$already_read){
		exit unless($config=~m/^\d+$/);
		my $sth=$dbh->prepare("select s.body from struct s where s.project_id=? and struct_id=?");
		$sth->execute($project->{project_id},$config);
		unless($sth->rows()){
			print_header();
			print "Конфиг не найден на сервере";
			exit;
		}
		my $conf=$sth->fetchrow();
		$sth->finish();
		
		$conf=~s/\[%project_id%\]/$project->{project_id}/gs;
		
		eval($conf);
    
		print $@ if($@);	

        if($form && !keys(%form)){
          %form=%{$form};
        }
		
	}

	$form->{project}=$project;
	$form->{project_id}=$form->{project}->{project_id};
    

	$form->{add_where}="wt.project_id=$project->{project_id}" unless($form{work_table}=~m/^struct/);
	
	# ---------
    
	$form->{action}=param('action');
    
	my $id=$cgi->param('id');
	if($id=~m/^\d+$/){
		$form->{id}=$id;
	}

	$form->{config}=$config;

	$form->{dbh}=$dbh;
	$form->{script}=$ENV{SCRIPT_NAME};
	$form->{script}=~s{(^.+[^\/]+)$}{$1};

#	$log->info($site,'action: ',$form{action});
	# События

	if($form->{action} eq 'insert'){ # при добавлении
		$form{events}->{before_insert}=&read_file('./conf/'.$config.'_before_insert') unless($form->{events}->{before_insert});
		$form{events}->{after_insert}=&read_file('./conf/'.$config.'_after_insert') unless($form->{events}->{after_insert});
	}
	if($form->{action} eq 'update'){ # при обновлении
#		$log->info($site,'action update, BEFORE_UPDATE');
		$form{events}->{before_update}=&read_file('./conf/'.$config.'_before_update') unless($form->{events}->{before_update});
#		$log->info($site,'action update, AFTER_UPDATE');
		$form{events}->{after_update}=&read_file('./conf/'.$config.'_after_update') unless($form->{events}->{after_update});
	}
	if($ENV{SCRIPT_NAME} eq 'delete_element'){ # при удалении
		$form->{events}->{before_delete}=&read_file('./conf/'.$config.'_before_delete') unless($form->{events}->{before_delete});
		$form->{events}->{after_delete}=&read_file('./conf/'.$config.'_after_delete') unless($form->{events}->{after_delete});
	}
	#our $form=\%form;
	# Права
	
	$form->{events}->{permissions}=&read_file('./conf/'.$config.'_permissions') unless($form->{events}->{permissions});
	#if(-f "./conf/$config\_permissions"){ # Здесь определяются права доступа к той или иной карточке
	#	do './conf/'.$config.'_permissions';
	#}
	
	#$form{events}->{permissions}=&add_code_to_event($form{events}->{permissions},'my $xxw=sub{print "Событие3<br/>";}; &$xxw;	');	
	#pre($form->{project}->{options}) if(param('debug'));
	# Опции проекта (модули)
	#$sth=$dbh->prepare("SELECT options FROM project where project_id=?");
	#$sth->execute($form->{project}->{project_id});

	my $project_options=$form->{project}->{options};
    $form->{project}->{options}={};
	while($project_options=~m/([^;]+)/gs){
		$plugname=$1;
        #pre($1);
		#print "qq{./plugins/svcms/$plugname}<br>";
		run_event(read_file(qq{./plugins/svcms/$plugname}));
		$form->{project}->{options}->{$plugname}=1
	}
    #pre($form->{project});

    
	run_event(read_file(qq{./plugins/svcms/promo}));
	run_event($form->{events}->{permissions});

	
    if($project->{domain} && 
        (
            $form->{action}=~m{(add|edit|update|delete|move)} || $form{script}=~m{(delete)}
        )
    ){
        
        #my $sth=$form->{dbh}->prepare("UPDATE template SET reset_cache_time=? where template_id=?");
        #$sth->execute(time(),
        #pre($project->{domain});

        clear_nginx_cache($dbh,$project->{domain});
        #if($project->{domain} ne $ENV{HTTP_HOST}){
        #	clear_nginx_cache($ENV{HTTP_HOST});
        #}
        
    }
    

#	$log->info($site,' end');
	return $form;
}
sub read_file{
	my $file=shift;
	if(-f $file){
		my $code='';
		open F, $file;
		while(<F>){
			$code.=$_;
		}
		close F;
		return $code;
	}
}

sub clear_nginx_cache{
    my $dbh=shift; my $domain=shift;
    my $sth=$dbh->prepare("UPDATE domain set need_clean_cache=1 WHERE domain=?");
    $sth->execute($domain);
    
    if($domain=~m{^[a-z0-9_\.\-]+$}i){
		$pid = fork();
		if( $pid == 0 ) {
	      close STDERR;
	      close STDIN;
	      close STDOUT;
		  `rm -f \$(grep -lr '$domain' /var/cache/nginx/*) &`;
		  exit 0;
		}
        
    }
    
}

sub pre{	
	print_header();
	print '<hr><pre>'.Dumper($_[0]).'</pre>';
}

sub print_header{
  #pre($form->{CHARSET_HTTP_HEADER});
  return if($form->{header_printed});
  print "Content-type: text/html; charset=cp1251\n\n";
  $form->{header_printed}=1;
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

return 1;
END { }
