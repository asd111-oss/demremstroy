#!/usr/bin/perl
#use strict;
use CGI qw(:standard);
use CGI::Carp qw (fatalsToBrowser);
use Data::Dumper;
use vars qw($DBname $DBhost $DBuser $DBpassword);
use Template;
use DBI;
 
print "Content-type: text/html\n\n";
         
do '../../connect';
my $dbh = DBI->connect("DBI:mysql:$DBname:$DBhost",$DBuser,$DBpassword, , { RaiseError => 1 }) || die($!);
my $params;

my $dep_id = param('dep_id');
$$params{TMPL_VARS}{dep_id} = $dep_id;


#список валют
$$params{TMPL_VARS}{valute} = $dbh->selectall_arrayref("select *,rubricator_id as id, concat('/files/project_2438/rubricator/',photo) as photo_and_path from struct_2438_valute order by sort asc",{Slice=>{}},);
 

#записываем данные
 if ( param('action') eq 'form_send' ) {

	my $table;
	
	if ( param('type') eq 'corp' ) {
		$table = 'struct_2438_course_corp';
	}
	else {
		$table = 'struct_2438_course_fiz';
	}

	#трем все что есть по данному отделению для выбранного типа лиц, ф/юр.
	my $sth = $dbh->prepare("delete from $table where department_id=?");
	   $sth->execute( $info->{department_id} ) || die $dbh->errstr;

	foreach my $v ( @{ $$params{TMPL_VARS}{valute} } ) {
		
		my $cnt = param('valute_'.$v->{id}.'_cnt');
		my $buy = param('valute_'.$v->{id}.'_buy');		
		my $sell = param('valute_'.$v->{id}.'_sell');		
		
		if ( !$cnt ) { $cnt = 0; }
		if ( !$buy ) { $buy = 0; }		
		if ( !$sell ) { $sell = 0; }		
		
		
		#&pre("insert into $table (cnt, buy, sell, valute_id, department_id) values ($cnt, $buy, $sell, $v->{id}, $info->{department_id})");
		
		$sth = $dbh->prepare("insert into $table (cnt, buy, sell, valute_id, department_id) values ($cnt, $buy, $sell, $v->{id}, $dep_id)");
		#$sth->execute( $cnt, $buy, $sell, $v->{id}, $info->{department_id} ) || die $dbh->errstr;
		$sth->execute() || die $dbh->errstr;
	}
	
	$sth->finish();


 }

	
$sth = $dbh->prepare('select * from struct_2438_department where id=?');
$sth->execute( $dep_id ) || die $dbh->errstr;
my $dep = $sth->fetchrow_hashref();
$sth->execute() || die $dbh->errstr;
			
#данные котировок
foreach my $v ( @{ $$params{TMPL_VARS}{valute} } ) {
	$v->{data_corp} = $dbh->selectall_hashref("select * from struct_2438_course_corp where valute_id=$v->{id} and department_id=$dep_id", 'valute_id');
	$v->{data_fiz} = $dbh->selectall_hashref("select * from struct_2438_course_fiz where valute_id=$v->{id} and department_id=$dep_id", 'valute_id');
}
	

my $template = Template->new({INCLUDE_PATH => '/www/sv-cms/htdocs/templates/bankirdom/'});
   $template->process('lk_moderator.tmpl', $params->{TMPL_VARS} );