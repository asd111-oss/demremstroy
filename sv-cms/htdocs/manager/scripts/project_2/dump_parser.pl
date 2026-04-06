#!/usr/bin/perl
use Carp;
use CGI::Carp qw/fatalsToBrowser/;
use CGI qw(:standard);
use Encode qw(decode); 
use Text::Iconv;
use DBI;
use Data::Dumper;
print "Content-type: text/html; charset=windows-1251\n\n";
my $action=param('action');
my $mes;
if($action eq 'upload'){
	do '../../connect';
	my $dbh = DBI->connect("DBI:mysql:$DBname:$DBhost",$DBuser,$DBpassword, , { RaiseError => 1 }) || die($!);
	my $file=param('file');
	my $dump='';
	
	while(<$file>){$dump.=$_};
	#close F;
	
	#print "upload!";
	my $converter = Text::Iconv->new( 'utf16',"cp1251");
	$dump = $converter->convert($dump);
	#print "dump: $dump";
	$dbh->do('delete from struct_2_cert');
	my $sth=$dbh->prepare("INSERT INTO struct_2_cert(fio,cert_key) values(?,?)");
	my $i=0;
	while($dump=~m/
		INSERT\s*
		\[dbo\].\[UserCertificate1\].+?\(.+?\)
		.+?VALUES\s*\(.+?convert\(text,\s*N'(.+?)'.+?\),.+?
		convert\(text,\sN'(.+?)'.+?\)/gsx)
	{
			my ($name,$key)=($1,$2);
			
			$key=~tr/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/;
			print "$name : $key<br/>";
			
			$i++;
			$sth->execute($name,$key);
	}
	$mes=qq{Дамп разобран ($i записей)};
}

	print qq{
		<html>
			<head>
				<title>Загрузка MS-SQL-дампа</title>
				<style>
					body {margin: 20px}
				</style>
			</head>
			<body>
			  <p style='color: red'>$mes</p>
				<h2>Загрузка MS SQL-дампа</h2>
				
				<form enctype="multipart/form-data" method="post">
					<input type='hidden' name='action' value='upload'>
					<input type='file' name='file'>&nbsp;<input type="submit" value="Загрузить">
				</form>
				
			</body>
		</html>
		};

