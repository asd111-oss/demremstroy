#!/usr/bin/perl
use strict;
use lib '.';
use warnings;
use CGI qw(:standard :param);
use CGI::Carp qw(fatalsToBrowser);
use lib '/home/isavnin/perl5/lib/perl5';
use FindBin qw($Bin);
use lib "$Bin/lib";
use appdbh;

our $dbh = appdbh->new;
init();

sub init {
  my $pid = param('pid') || param('project_id');
  render('Project config not found!','error') unless $pid;
  my $conf = $dbh->selectrow_hashref(
    'SELECT id, counter FROM ecommerce WHERE project_id = ?',
    undef,
    $pid
  );
  if ( !$conf && $ENV{REQUEST_METHOD} eq 'POST' && !param('cid') ){
    my $counter = param('counter') || '';
    $dbh->do("INSERT INTO ecommerce(project_id,counter) VALUES(?,?)",undef,($pid,$counter));
    $conf = $dbh->selectrow_hashref(
      'SELECT id, counter FROM ecommerce WHERE project_id = ?',
      undef,
      $pid
    );
  }
#  render('Config not found!','error') unless $conf;
  update() if param('cid');
  $conf = $dbh->selectrow_hashref('SELECT id,counter FROM ecommerce WHERE project_id = ?',undef,$pid);
  my $html = qq{
    <div style="padding:10px; margin:10px;">
    <form action="" method="post">      
      <input type="hidden" name="cid" value="$conf->{id}"/>
      <input type="hidden" name="project_id" value="$pid"/>
      <p>E-commerce counter</p>
      <textarea name="counter" rows="10" width="300">$conf->{counter}</textarea><br/>
      <button type="submit">Сохранить</button>
    </form>
    </div>
  };
  render($html);
}

sub update {
  my ( $cid, $pid, $counter ) = ( param('cid'), param('project_id'), param('counter') );
  render('Params not defined'.param('cid'),'error') if ( !$pid || !$counter );
  my $sql = 'UPDATE ecommerce SET counter = ? WHERE project_id = ? AND id = ?';
  my @bind = ($counter,$pid,$cid);
  if ( !$cid ){
    $sql = 'INSERT INTO ecommerce(project_id) VALUES(?)';
    @bind = ($pid);
  }
  $dbh->do(
    $sql,
    undef,
    @bind
  );  
}

sub render {
  my ( $data, $type ) = @_;
  print header( -type => 'text/html; charset=windows-1251', -status=>200 );
  if ( $type =~ /error/ ){
    print '<div style="color:red;">'.$data.'</div>';
  }
  else{
    print $data;
  }
#  exit;
}
