use warnings;
no warnings;

use Time::HiRes qw(gettimeofday);


sub custom_processors {
    my $stream=shift;

    if ( index($::params->{project}->{options},'generate_description')>=1 ){
      if(!$::params->{TMPL_VARS}{promo}{description}){
        my $s=$::params->{TMPL_VARS}{content}{body}||$::params->{TMPL_VARS}{content}{anons};
        $s=~ s/<[^>]*>//g;
        $s=~ s/^[ \t]*//;
        $s=~ s/[ \t]*$//;
        $s=~ s/"//g;
        $s=~ s/'//g;
        $s=~ s/\n/ /g;
        $s=substr($s,0,255);
        $stream =~s!<meta name="Description" content="(.+)" />!<meta name="Description" content="$s" />!g;
      }
    }

    if ( index($::params->{project}->{options},'post_proccessing')>=1 ) {
    $stream =~s!<(div)(.+?h1.+?)>(.+?)</div>!<h1$2>$3</h1>!ig;
    $stream =~s!<(div)(.+?h2.+?)>(.+?)</div>!<h2$2>$3</h2>!ig;
    $stream =~s!<(div)(.+?h3.+?)>(.+?)</div>!<h3$2>$3</h3>!ig;

    }

    print $stream;
}
#/********************************************************/#