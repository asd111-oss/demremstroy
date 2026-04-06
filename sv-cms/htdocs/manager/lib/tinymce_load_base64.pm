=cut
  
=cut
package tinymce_load_base64;
use Data::Dumper;
use DBI;
use CGI qw(:standard);
use strict;
use MIME::Base64;

sub init{
  my $form=shift; $::form=$form;
  my $path_to_save=shift;
  push @{$form->{events}->{before_save}},
  sub{
    #&::print_header();
    #&::pre('is init!');
    return if($form->{readonly} || $form->{read_only});
    foreach my $f (@{$form->{fields}}){
      if($f->{type} eq 'wysiwyg' && !$f->{read_only} && !$f->{readonly}){
        process_save($form,$f,$path_to_save);
      }
    }
  }
  
}

sub process_save{
  my $form=shift; my $field=shift; my $path_to_save=shift;
  #print $field->{value}; exit;
  while($field->{value}=~m{\s+src="(data:(.+);.*?base64,(.+?))"}gs){
    
    my ($src,$mime,$c)=($1,$2,$3);
    #print qq{src: $src\nmime:$mime\nc: $c};
    $src=~s{[/\+]}{\\/}gs;
    my $fullname=$path_to_save.'/'.filename();
    #print "fullname: $fullname";
    open F, '>'.$fullname;
    binmode F;
    print F MIME::Base64::decode($c);
    close F;
    $form->{new_values}->{$field->{name}}=~s{\s+src="(data:(.+);.*?base64,(.+?))"}{ src="$fullname"}s;
    #print "value: $field->{value}\n";
    #exit;
  }

  
  #exit;
}

sub filename{
  return (time().'_'.int(rand()*100000)).'.png';
}

sub pre{
	my $s=shift;
	print '<pre>'.Dumper($s).'</pre>';
}
sub print_error{
	my $e=shift;
	print "Content-type: text/html\n\n$e";
	exit;
}


return 1;
END { }
