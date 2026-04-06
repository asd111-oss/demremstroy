#!/usr/bin/perl
use Template;
use DBI;
use CGI::Fast qw(:standard);
use warnings;
no warnings;
$ENV{HTTP_HOST}='design-b2b.com' unless($ENV{HTTP_HOST});
$CGI::LIST_CONTEXT_WARN = 0;
#use FCGI::ProcManager;
#use FCGI::ProcManager qw(pm_manage pm_pre_dispatch pm_post_dispatch);
#use FCGI::ProcManager qw(pm_manage pm_die pm_exit pm_pre_dispatch pm_post_dispatch);
#exit;
#print "Content-type: text/html\n\n"; exit;

#my $proc_manager = FCGI::ProcManager->new({ n_processes => 50, pm_title=> 'processmanager: work.fcgi ' });
#pm_manage( n_processes => 5 );
use CGI::Cookie;
use CGI::Carp qw/croak fatalsToBrowser/;
use Data::Dumper;
use MIME::Lite;
use MIME::Base64;
use lib 'lib';
use db;
use basket_par; # работа с корзиной
use send_msg_html; # отправка HTML писем
#use db;
#use capture; # капча
# - sanman --
use Encode;
#------------
#use strict;

our $system=&get_system;
$system->{debug};
$system->{fast_cgi_maxcount}=7;
$system->{logname}='log_cgi';
our $CACHE; # ссылка на кеш
#exit;
# Hide CGI warning
#$CGI::LIST_CONTEXT_WARN = 0;

##########
=cut
my $WR555;
open $WR555, ">>/tmp/dump_20_02_001";
print $WR555 "_____________________\n".`date`."\n";
print $WR555 Data::Dumper->Dump( [ $ENV{HTTP_REFERER} ], ['$ENV{HTTP_REFERER}'] );
print $WR555 Data::Dumper->Dump( [ $ENV{HTTP_X_FORWARDED_FOR} ], ['$ENV{HTTP_X_FORWARDED_FOR}'] );
close $WR555;
=cut
##########

#while (new CGI::Fast) {
#while (CGI::Fast->new){
    #pm_pre_dispatch();
    #print "Content-type: text/html\n\n";
    #print "ZZZ";
    #print $ENV{HTTP_HOST}."\n";
    if(!$ENV{HTTP_HOST}){
      $ENV{HTTP_HOST}='russlovo.today';
      $system->{debug}=1;
      
    }
    our $params;
    &fcgi_loop;
#}








