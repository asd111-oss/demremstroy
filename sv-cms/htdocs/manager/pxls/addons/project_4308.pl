#!/usr/bin/perl -w
#use strict;
use Data::Dumper;
use DBI;
#use lib '/var/www/sv-cms/htdocs/lib';
#use appdbh;
#my $dbh = appdbh->new();
#$dbh->do('set names utf8');

use vars qw($DBname $DBhost $DBuser $DBpassword);

do '/var/www/sv-cms/htdocs/manager/connect';
my $dbh=DBI->connect("DBI:mysql:$DBname:$DBhost",$DBuser,$DBpassword, , { RaiseError => 1 }) || die($!);

my $project_id = '4308';
my $sth = $dbh->prepare(
	"SELECT good_id,price_sizes FROM struct_${project_id}_good WHERE price_sizes<>''"
);
$sth->execute();
while(my $good = $sth->fetchrow_hashref()){
	if($good->{price_sizes}){
		$dbh->do("update struct_${project_id}_good set price_sizes='' where good_id=".$good->{good_id});
		my @price_sizes = split(';',$good->{price_sizes});
		foreach my $p (@price_sizes){
			if($p=~/^(.+)\((.+)\)/){
				my ($price,@sizes) = (trim($1),map {"'".trim($_)."'"} split(',',$2));
				if($price>=0){					
					my @size_ids=();
					foreach(@sizes){
						my ($size_id) = $dbh->selectrow_array(
							"SELECT size_id FROM struct_${project_id}_size WHERE header like ".$_." LIMIT 1" 
						);
						if( $size_id ){
							push @size_ids, $size_id;
						}else{
							$dbh->do("INSERT INTO struct_${project_id}_size set header=".$_);
							my $size_id = $dbh->{'mysql_insertid'};
							push @size_ids, $size_id;
						}
					}
					if( scalar(@size_ids) ){
						$dbh->do("DELETE FROM struct_${project_id}_good_size WHERE good_id=".$good->{good_id});
						foreach(@size_ids){
							$dbh->do("INSERT IGNORE struct_${project_id}_good_size set price='".$price."', size_id='".$_."', good_id=".$good->{good_id});
						}
					}
				}
			}
		}		
	}
}

sub trim {
	my($string)=@_;
	for ($string) {
	    s/^\s+//;
	    s/\s+$//;
	    s/[\'\"]//;
	}
	return $string;
}


