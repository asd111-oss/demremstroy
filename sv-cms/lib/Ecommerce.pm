package Ecommerce;
use strict;
use warnings;
#use CGI qw/:standart :param/;
use Data::Dumper;
use JSON::XS;
use SQL::Abstract;
use appdbh;

require Exporter;

our @ISA = qw(Exporter);
our @EXPORT = qw(
  view_good
  add_good
  del_good
  create_order
);
our $VERSION = '0.01';

=head1 Описание
Модуль для генерации JSON ответов для Яндекс.Метрики раздела E-commerce
=cut

=head1 Переменные
Переменные для работы с БД
$dbh - БД хандлер
$sa - Построитель запросов
$jxs - JSON сериализатор
=cut
our $dbh = appdbh->new;
our $sa = SQL::Abstract->new;
our $jxs = JSON::XS->new->pretty(1);

our $obj = { ecommerce => {} };

=head1 Методы
=cut

=head2 get_conf ( cid )
Получаем конфиг для коммерции, где cid - уникальный номер конфига. В котором храниться инфа о таблицах и полях для работы и генерации ответов
=cut
sub get_conf {
  my ( $cid ) = @_;
  my ( $sql, @bind ) = $sa->select(
    'ecommerce',
    '*',
    { id => $cid }
  );
  return $dbh->selectrow_hashref( $sql, undef, @bind );
}

=head2 get_good ( gid )
Получаем товар, где gid - ИД товара в БД
=cut
sub get_good {
  my ( $gid, $conf ) = @_;
  my $w = { "$conf->{gid_field}" => $gid };
#  unless ( $w->{not_use_pid} ){
  unless ( $conf->{good_table} =~ /^struct/ ){
    $w->{project_id} = $conf->{project_id};
  }
  my ( $sql, @bind ) = $sa->select(
    $conf->{good_table},
    $conf->{fields},
    $w
  );
  my $good = $dbh->selectrow_hashref( $sql, undef, @bind );
  $good->{price} = $good->{price} + 0;
  return $good;
}

=head2 view_good ( gid, cid );
Возврат JSON "Просмотр товра", где gid - ИД товара в БД, cid - ИД конфига для получения инфы о проекте, таблицах и полях
=cut
sub view_good {
  my ( $gid, $cid ) = @_;
  my $conf = get_conf( $cid );
  my $good = get_good( $gid, $conf );
  my $obj = { ecommerce => { detail => { products => [ $good ] } } };
  return $jxs->encode( $obj );
}

=head2 add_good ( gid, cid, cnt );
"Добавление товара в корзину", gid - ИД товара в БД, cid - ИД кофига, cnt - кол-во добавляемых товаров
=cut
sub add_good {
  my ( $gid, $cid, $cnt ) = @_;
  my $conf = get_conf( $cid );
  my $good = get_good( $gid, $conf );
  $good->{quantity} = $cnt + 0;
  my $obj = { ecommerce => { add => { products => [ $good ] } } };
  return $jxs->encode( $obj );
}

=head2 del_good ( gid, cid );
"Удаление товара из корзины", gid - ИД товара, cid - ИД конфига
=cut
sub del_good {
  my ( $gid, $cid ) = @_;
  my $conf = get_conf( $cid );
  my $good = get_conf( $gid, $conf );
  my $obj = { ecommerce => { remove => { products => [ $good ] } } };
  return $jxs->encode( $obj );
}

=head2 create_order ( good_list, cid );
"Покупка", cid - ИД конфига, good_list - список товаров и их кол-во на данный момент формат good_list = 'GID:CNT;GID:CNT;'
=cut
sub create_order {
  my ( $cid, $good_list, $oid ) = @_;
  my $conf = get_conf( $cid );
  my @gids = split( ';', $good_list );
  my $obj = { ecommerce => { purchase => { actionField => { id => $oid }, products => [] } } };
  map {
    if ( $_ =~ /^(\d+):(\d+)$/ ){
      my $good = get_good($1,$conf);
      $good->{quantity} = $2 + 0;
      push @{$obj->{ecommerce}{purchase}{products}}, $good;
    } 
  } @gids;
  return $jxs->encode( $obj );
}

1;
