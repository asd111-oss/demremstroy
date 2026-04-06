#!/usr/bin/perl

use strict;

use DBI;
# use Encode;
# use Data::Dumper;


#=======================
# DATABASE
#
use vars qw($DBname $DBhost $DBuser $DBpassword);
do '/www/sv-cms/htdocs/manager/connect';
my $dbh=DBI->connect("DBI:mysql:$DBname:$DBhost",$DBuser,$DBpassword, , { RaiseError => 1 }) || die($!);


# open LOG, ">>/tmp/pxls-154.log";


my $PROJECT_ID=154;

# my $sql="UPDATE good SET price=0 WHERE project_id=$PROJECT_ID && good_id IN (84201,84195,84199)";
my $sql="UPDATE good SET price=0 WHERE project_id=$PROJECT_ID";

$dbh->do($sql);

# printf LOG "test %d\n", time();
# print LOG "$sql\n";

# close LOG;
