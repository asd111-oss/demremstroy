#!/usr/bin/perl 

use strict;

use DBI;
# use Encode;
# use Data::Dumper;


#=======================
# DATABASE
#
use vars qw($DBname $DBhost $DBuser $DBpassword);
# do '../connect';
do '/www/sv-cms/htdocs/manager/connect';
my $dbh=DBI->connect("DBI:mysql:$DBname:$DBhost",$DBuser,$DBpassword, , { RaiseError => 1 }) || die($!);

#=======================

my $tab={
	goods	=> 'struct_53_goods',
	ages	=> 'struct_53_ages',
	ga		=> 'struct_53_goods_age',
};

my $goods=$dbh->selectall_arrayref("SELECT goods_id, g1, g2, g3, g4, g5, g6 FROM $$tab{goods}", {Slice=>{}});
my $ages_gx=$dbh->selectall_hashref("SELECT gx, age_id FROM $$tab{ages}", 'gx');

my @ages_gx_keys=keys %$ages_gx;

my @gx=();

foreach my $g (@$goods){
	map { push @gx, sprintf( "(%d,%d)", $$g{goods_id}, $$ages_gx{$_}{age_id} ) if $$g{"g$_"} } @ages_gx_keys;
}

my $sql="INSERT INTO $$tab{ga} (goods_id, age_id) VALUES ".join( ",", @gx );

# print $sql, ";\n";

$dbh->do("DELETE from $$tab{ga}");
$dbh->do($sql);

1;
