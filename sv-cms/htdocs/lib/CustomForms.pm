package CustomForms;
use strict;
use warnings;
use appdbh;
use SQL::Abstract;
use JSON::XS;
use CGI::HTML::Functies;

require Exporter;

our @ISA = qw(Exporter);
our @EXPORT = qw(  
  add_form
  show_form
);

our @VERSION = '0.0.1';

our $dbh = appdbh->new;
our $sa = SQL::Abstract->new;
our $jxs = JSON::XS->new->pretty(1);

sub new {
  my $cls = shift;
  my $self ={};
  bless $self, ref $cls || $csl;
  my $opt = shift;
  
  $self->{project} = $opt->{project};

  return $self;
}

sub add_form {

}

sub show_form {}

1;
