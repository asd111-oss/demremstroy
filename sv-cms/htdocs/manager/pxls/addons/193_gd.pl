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
	tmp		=> 'struct_193_goods_distr_tmp',
	goods	=> 'struct_193_goods',
	distr   => 'struct_193_distributor',
	cross 	=> 'struct_193_goods_distributor',
};

my $sql_insert_goods="INSERT INTO $$tab{goods} SET header=?, article=?";
my $sql_insert_cross="INSERT INTO $$tab{cross} SET goods_id=?, distributor_id=?, edinica=?, in_rezerve=?, in_tranzite=?, available_to_order=?, is_new=1";

#=======================
my $tmp_goods=$dbh->selectall_arrayref(
	"SELECT * ".
	"FROM $$tab{tmp}",
	{Slice=>{}}
);

my $distr_id_hash={};

foreach my $g (@$tmp_goods)
{
	$$g{artikul}=~s/^\s+|\s+$//gs;

	my ($goods_id)=$dbh->selectrow_array(
		"SELECT goods_id FROM $$tab{goods} WHERE article=?",
		undef,
		$$g{artikul}
	);

	if( !$goods_id )
	{
		if( $dbh->do( $sql_insert_goods, undef, $$g{header}, $$g{artikul} ) )
		{
			( $goods_id )=$dbh->selectrow_array("SELECT LAST_INSERT_ID()");
		}
	}

	if( $goods_id )
	{
		$dbh->do(
			$sql_insert_cross,
			undef,
			$goods_id,
			$$g{distributor_id},
			$$g{unit},
			($$g{cnt_reserve} || 0),
			($$g{cnt_transit} || 0),
			($$g{cnt_available} || 0)
		);

		$$distr_id_hash{ $$g{distributor_id} } ||= 1;
	}
}

while( my ($id)=each %$distr_id_hash )
{
	$dbh->do("DELETE FROM $$tab{cross} WHERE is_new=0 && distributor_id=$id");
}

$dbh->do("UPDATE $$tab{cross} SET is_new=0 WHERE is_new=1");

$dbh->do("TRUNCATE $$tab{tmp}");
