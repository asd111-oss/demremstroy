#!/usr/bin/perl
use strict;
use warnings;
use DBI;

my $dbh = DBI->connect('dbi:mysql:svcms:192.168.8.81','svcms','',{RaiseError=>1}) or die($!);

my $data = $dbh->selectall_arrayref("SELECT ans_id FROM struct_5082_test_ans WHERE type = 1 GROUP BY ans_id HAVING count(*) > 1",{Slice=>{}});
foreach my $row ( @{$data} ){
    my $min_id = $dbh->selectrow_hashref("SELECT min(id) as id FROM struct_5082_test_ans WHERE ans_id = ? AND type = 1",undef,$row->{ans_id});
    $dbh->do(
        "UPDATE struct_5082_test_ans SET type = 0 WHERE type = 1 AND ans_id = ? AND id > ?",
        undef,
        ($row->{ans_id},$min_id->{id})
    );
}
