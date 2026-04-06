#!/usr/bin/perl
use strict;
use warnings;
use Spreadsheet::WriteExcel;
use CGI qw/:standard/;
$CGI::LIST_CONTEXT_WARN = 0;
use Log::Any '$log', prefix => '[gen_tmpl]';
use Log::Any::Adapter('Stdout','log_level','error'); #'File','/home/isavnin/pxls.log','log_level','error');
#use encoding "ru_RU.CP1251";

use lib '../lib';
#use appdbh;
use Encode;
use DBI;
do '../connect';
#use encoding 'utf8';
use utf8;
our $svcms_host;
our($DBname, $DBhost, $DBpassword, $DBuser);
our $VERSION = '0.0.2';
our $dbh=DBI->connect("DBI:mysql:$DBname:$DBhost",$DBuser,$DBpassword,,{RaiseError=>1}) || die($!);
$dbh->do("SET NAMES utf8");

#our $dbh = appdbh->new;
#$dbh->do("SET NAME");

load_config();

sub gen_tmpl {
  my ( $cfg ) = @_;
#  out( 'application/vnd.ms-excel', 200 );
  print "Content-type: application/vnd.ms-excel\n";
  print "Content-Disposition: attachment; filename=tmpl.xls\n\n";
  my $wb = Spreadsheet::WriteExcel->new("-");
  my $ws = $wb->add_worksheet();
  #$log->debug($cfg);
  eval( $cfg );
  use vars qw($config);

  my $col = 0;
  
  if ( defined $config->{item}{table} && defined $config->{item}{fields} ){
    map {
      unless ( !defined $_->{header} || ( defined $_->{core} && $_->{core} == 1 ) ){
        $log->debug('COL:',$col,' ',$_->{header});
        $ws->write( 0, $col, $_->{header} ); # encode('cp1251',decode('utf8',$_->{header} )));
        $col += 1;
      }
    } @{$config->{item}{fields}};
  }
  
  $wb->close();
}

sub load_config {
  $log->debug( param('config_id') );
  if ( param( 'config_id' ) =~ /^(\d+)$/ ){
    if ( my $cfg = get_config( $1 ) ){
      gen_tmpl( $cfg );
    }     
  }
  else {
    out();
  }
}

sub get_config {
  my ( $cid ) = @_;
  my $row = $dbh->selectrow_hashref( 
    "SELECT body FROM pxls WHERE id = ?", undef, ($cid) );
  return $row->{body} || undef;
}

# Общая функция для вывода
sub out {
  my ( $type, $code, $data ) = @_;
  $type = 'text/html' unless $type;
  $code = 404 unless $code;
  $data = 'Page not found' unless $data;
  print header( -type => $type, -code => $code );
  print $data if defined $data && $code == 404;
#  exit;
}
