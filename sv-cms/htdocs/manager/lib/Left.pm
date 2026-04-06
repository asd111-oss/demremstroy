package Left;
use strict;
use warnings;
use appdbh;
use Template;
use SQL::Abstract;
use Data::Dumper;
use CGI qw/:standard :param/;
require Exporter;

use lib '/home/isavnin/perl5/lib/perl5';
use CGI::Debug ( on => 'fatals' );

our @ISA = qw(Exporter);
our @EXPORT = qw();
our $VERSION = '0.01';
our $dbh = appdbh->new;
our $sa = SQL::Abstract->new;


sub new {
  my ( $self, $opt ) = @_;
  return bless {
    dbh => appdbh->new,
    tmpl => 'left.tmpl',
  }, $self;
}

sub run {
  my ( $self ) = @_;
  $self->{user} = get_user($ENV{REMOTE_USER});
  $self->{options} = 
}

sub get_user {
  my ( $user ) = @_;
  my ( $sql, @bind ) = $sa->select( 'manager', 'project_id, manager_id', { login => $user } );
  my $manager = $dbh->selectrow_hashref( $sql, undef, @bind );
  stop(403,'Auth error') unless manager
  return $manager;
}

sub stop {
  my ( $code, $msg ) = @_;
  print header ( -type => 'text/html', -charser => 'windows-1251', -status => $code );
  print $msg;
  exit;
}

1;
