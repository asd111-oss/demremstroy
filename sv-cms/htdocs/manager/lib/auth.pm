#!/usr/bin/perl
# Isavnin
# Модуль проверки правильности авторизации
package auth;
use CGI;
use Data::Dumper;
use strict;
use warnings;
our ($svcms_host, $DBpassword, $DBname, $DBuser, $DBhost);
do '/var/www/sv-cms/htdocs/manager/connect';
use CGI::Carp qw(fatalsToBrowser);
use lib 'lib';
use appdbh;

sub new {
	my $self = shift;
	my $user = $ENV{REMOTE_USER};# || 'intel';
	my $host = $ENV{HTTP_HOST};# || 'intel.designb2b.ru';
#	print Dumper($user);
#	print Dumper($host);
	$host =~ s/^www\.//;
	my $dbh = appdbh->new();
	
	#print "Content-type: text/html\n\n$host";
	#my $domain = $dbh->selectrow_hashref('SELECT project_id,domain from domain where domain=?', undef, ($host));
	##print Dumper($domain);
	#my $sql = "SELECT IF ( count(m.login) > 0, 'True', 'False') as ans 
	#           FROM manager m
	#	   INNER JOIN domain d ON d.project_id = m.project_id
	#	   WHERE m.login = ? AND d.domain = ?";
	#my @bind = ($user, $host);

	my $sth=$dbh->prepare('SELECT manager_id,full_access from manager where login=?');
	$sth->execute($ENV{REMOTE_USER});
	my $manager=$sth->fetchrow_hashref();
	$sth->finish();

	$manager->{project_id}=get_project_id(
		connect=>$dbh,
		manager_id=>$manager->{manager_id},
		domain=>$host,
		login=>$manager->{login},
		full_access=>$manager->{full_access}
	);
	#print "Content-type: text/html\n\n";
	#print Dumper($manager);
	if($manager->{project_id}){
		return 'True'
	}
	else{
		return 'False'
	}
#	my $ans = $dbh->selectrow_hashref("
#		SELECT IF(count(m.login) > 0,'True','False') as ans 
#		FROM manager m INNER JOIN domain d ON d.project_id = m.project_id WHERE m.login = ? AND d.domain like ?",
#		undef,($user,'%'.$host)) or die($!);
#	print Dumper($ans);
#	print Dumper($sql);
#	print Dumper(\@bind);
	#my $ans = $dbh->selectrow_hashref($sql, undef, @bind);
	#return $ans->{ans};
}

sub get_project_id{
	my %arg=@_;
	my $dbh=$arg{connect} if($arg{connect});
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


1;


