#!/usr/bin/perl
use lib 'lib';
use auth;
use CGI qw/:standard :param/;
use CGI::Carp qw(fatalsToBrowser);
use Data::Dumper;
do './connect';
#print header(-type=>'text/html',-charset=>'windows-1251');
our $dbh = DBI->connect("DBI:mysql:$DBname:$DBhost",$DBuser,$DBpassword, , { RaiseError => 1 }) || die($!);
$dbh->do("SET names CP1251");
my $sth=$dbh->prepare('SELECT manager_id,full_access from manager where login=?');
$sth->execute($ENV{REMOTE_USER});

my $manager=$sth->fetchrow_hashref();
$sth->finish();
my $domain=$ENV{HTTP_HOST};

my $domain_without_www=$domain;
$domain_without_www=~s{^www\.}{};

$manager->{project_id}=get_project_id(
	manager_id=>$manager->{manager_id},
	domain=>$domain_without_www,
	login=>$ENV{REMOTE_USER},
	full_access=>$manager->{full_access}
);



if($manager->{project_id}){
	

	
	if(1){
		#use Data::Dumper;
		#print '<pre>'.Dumper(\%ENV).'</pre>';
		#print "$ENV{HTTP_HOST} $ENV{REMOTE_USER}\n";
		



		my $sth=$dbh->prepare("SELECT d.server_type,d.is_ssl FROM manager m left join project p ON p.project_id=m.project_id join domain d ON d.project_id=d.project_id WHERE m.login=? and d.domain=?");
		$sth->execute($ENV{REMOTE_USER},$domain_without_www);
		my ($server_type,$is_ssl)=$sth->fetchrow();
		#  if(param('debug')){
		#  	print "Content-type: text/html\n\n";
		#  	print Dumper([$server_type,$is_ssl]); 
		#  	print Dumper({
		#  		manager_id=>$manager->{manager_id},
		#  		domain=>$domain_without_www,
		#  		login=>$ENV{REMOTE_USER},
		#  		full_access=>$manager->{full_access}
		#  	});
		#  	exit;
		# }
		if($server_type==3){ # PSGI
			#print header(-status=>200,-type=>'text/html',-charset=>'windows-1251');
			#use Data::Dumper;
			#print Dumper(\%ENV);
			#print "is_ssl: $is_ssl\n";
			my $protocol=(($is_ssl)?'https':'http');
			print "Location: $protocol://$domain/manager2\n\n";
			exit;
		}
		#print "t: $server_type\n";
	}
	print header(-status=>200,-type=>'text/html',-charset=>'windows-1251');
        my $left = param('new') ? 'left_new.pl' : 'left.pl';
	print qq{
		<title>SvCMS - $ENV{HTTP_HOST}</title>
		<frameset cols="300,*" scrolling="auto" frameborder="no" framespacing="0">
	           <frame name="left" frameborder="no" marginheight="0" marginwidth="0" src="$left">
	           <frame name="main" scrolling="auto" topmargin=5 leftmargin=5 marginheight="0" frameborder="yes" marginwidth="0" src="start.pl">
		</frameset>
	};
}else{
	print header(-type=>'text/html',-charset=>'windows-1251');
	print qq{Ошибка авторизации};
	#print Dumper($manager);
	#print header(-status=>401,-type=>'text/html',-charset=>'windows-1251');
	#exit print redirect(-uri=>'http://'.$ENV{HTTP_HOST},-status=>'301');
	#print qq{<h1>403</h1><h2>Ошибка авторизации!</h2>};
}

sub get_project_id{
	my %arg=@_;
	#print qq{SELECT project_id FROM domain where domain="$arg{domain}"};
	my $sth=$dbh->prepare(qq{SELECT project_id FROM domain where domain="$arg{domain}"});
	$sth->execute();
	my $project_id=$sth->fetchrow();
	
	unless($project_id){ # проект не найден
		return undef
	}

	if($arg{full_access}){
		return $project_id
	}
	else{

		my $sth=$dbh->prepare(q{
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
