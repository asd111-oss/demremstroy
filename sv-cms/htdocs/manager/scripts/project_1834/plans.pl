#!/usr/bin/perl

use strict;
use CGI qw(:standard);
use CGI::Carp qw (fatalsToBrowser);
use Data::Dumper;
use vars qw($DBname $DBhost $DBuser $DBpassword);
         
#use lib '/var/www/client_sites/kubgs/htdocs/modules';
use lib '/var/www/sv-cms/htdocs/manager/scripts/project_1136/modules';

use PV::dbase;
use PV::tpl;

do '../../connect';

my $dbh = dbase->new($DBhost,$DBname,$DBuser,$DBpassword);
my $t = tpl->new('/var/www/sv-cms/htdocs/manager/scripts/project_1834/');

my $img_root_path = '/var/www/sv-cms/htdocs/files/project_1834/plans';
#my $img_root_path = './img';

my $parent_id = param('parent_id');
my $floor_number = param('floor_number');
my $fh = param('fh');

if(param('plan_add') && $fh){
	unless(-d $img_root_path){
		mkdir $img_root_path;
		chmod 0777, $img_root_path;
	}

	my $ext = '';
	if($fh =~ /\.(.*?)$/i){
		$ext = $1;
		$ext = substr($ext, -4, 4) if (length "$ext">4);
	}
	$ext = lc $ext;

	if ($ext eq 'gif' || $ext eq 'jpeg' || $ext eq 'jpg' || $ext eq 'png') {
		my $uniquename = $parent_id.'_'.$floor_number;
		my $filename = $uniquename.".".$ext;
		my $file = $img_root_path.'/'.$filename;

		open (FL, ">$file") or die ("($!) Cannot open file $file");
		binmode FL;
		print FL while (<$fh>);
		close (FL);
		$dbh->query("delete from struct_1834_plans where parent_id=? and floor_number=?", $parent_id, $floor_number);
		$dbh->query("INSERT struct_1834_plans SET parent_id=?, floor_number=?, photo=?", $parent_id, $floor_number, $filename);
	}

	$t->redirect("./plans.pl?parent_id=$parent_id");
} elsif (param('plan_del') =~ /^(\d+)$/) {
	my $plan = $dbh->select_one("SELECT * FROM struct_1834_plans WHERE id=?", $1);

	if (exists $plan->{id}) {
		$dbh->query("DELETE FROM struct_1834_plans WHERE id=?", $1);

		unlink $img_root_path.'/'.$plan->{file};
	}

	$t->redirect("./plans.pl?parent_id=$parent_id");
}

my $floors = $dbh->select_one("SELECT f.header
	FROM struct_1834_floors f
	LEFT JOIN struct_1834_sections sl ON sl.floor_id=f.id
	WHERE sl.id=?
", $parent_id);

my ($plans) = $dbh->select_all("SELECT * FROM struct_1834_plans WHERE parent_id=?", $parent_id);
my %plan = ();

map { $plan{$_->{floor_number}} = { id => $_->{id}, photo => $_->{photo}, }; } @$plans;

$t->output('plans.html', {
	parent_id => $parent_id,
	floors => $floors,
	plan => \%plan,
});
