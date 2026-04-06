package appdbh;
use vars qw($svcms_host $DBname $DBuser $DBpassword $DBhost);
use strict;
use warnings;

use DBI;
use CGI;
use Data::Dumper;
our ($svcms_host,$DBname,$DBuser,$DBhost,$DBpassword);
#my $HOME = $ENV{DOCUMENT_ROOT} ? $ENV{DOCUMENT_ROOT} : '/var/www/sv-cms/htdocs';
#my $HOME = '/var/www/sv-cms/htdocs';
#print "$HOME";
do '/var/www/sv-cms/htdocs/manager/connect';

sub new {
	my $self = shift;
	my $user = $DBuser ? $DBuser : 'svcms';
	my $name = $DBname ? $DBname : 'svcms';
	my $host = $DBhost ? $DBhost : $svcms_host;
	my $pass = ''; #$DBpassword ? $DBpassword : 'svcms';
	my $dsn = 'DBI:mysql:'.$name.':'.$host;
	return DBI->connect($dsn,$user,$pass,,{RaiseError=>1}) || die($!);
}

1;
