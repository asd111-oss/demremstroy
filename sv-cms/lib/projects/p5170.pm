package p5170;
use JSON::XS;
use Encode qw(encode decode);
use CGI qw/param/;
use JSON::XS;
my $json;

sub ajax{
            
    $tv = $::params->{TMPL_VARS};
    $tv->{page_type} = 'ajax.tmpl';

    my $dbh = $::params->{dbh};
    $dbh->do("SET NAMES utf8");

    my $json = new JSON::XS;
    $json = $json->pretty(1);
    my $method = $ENV{REQUEST_METHOD};
    my $func   = param('func');

    if ( $func =~ /^(podbor|getBrandGoods)$/ ) {
        our $brand =
            $::params->{dbh}->selectall_hashref(
            "SELECT id,header,concat('/brand/',id) as url FROM struct_5170_brand",
            "id" );
        our $fav_list;
        if ( $tv->{user}{is_auth} == 1 ) {
            $fav_list =
                $::params->{dbh}->selectall_hashref(
                "SELECT good_id, 1 as fav FROM struct_5170_user_fav WHERE user_id = ?",
                "good_id", undef, $tv->{user}{user_id} );
        }

    }

    if ( $method eq 'POST' ) {
        if    ( $func eq 'add2fav' )       { &add2fav(); }
        elsif ( $func eq 'del_from_fav' )  { &del_from_fav(); }
        elsif ( $func eq 'login' )         { &login(); }
        elsif ( $func eq 'podbor' )        { &podbor(); }
        elsif ( $func eq 'getBrandGoods' ) { &getBrandGoods(); }
    }
    elsif ( $method eq 'GET' ) {
        if    ( $func eq 'goodInfo' )      { &get_goodInfo(); }
        elsif ( $func eq 'BskInfo' )       { &get_BskInfo(); }
        elsif ( $func eq 'podbor' )        { &podbor(); }
        elsif ( $func eq 'getBrandGoods' ) { &getBrandGoods(); }
    }
    else {
        &ans();
    }


        sub getBrandGoods {
            $::params->{dbh}->do("SET NAMES cp1251");

            my @bind = (1);
            my @w    = ('g.enabled = ?');


            if ( my $pid = param('pid') ) {
                push @bind, $pid;
                push @w,    'gp.param_id = ?';
            }

            if ( my $bid = param('bid') ) {
                push @bind, $bid;
                push @w,    'g.brand_id = ?';
            }

            my $page = 1;
            if ( param('page') && param('page') =~ /^(\d+)$/ ) {
                $page = $1;
            }

            my $limit = 10;
            my $start = ( $page - 1 ) * $limit;

            @bind = ( @bind, $start, $limit );

            my $goods = $::params->{dbh}->selectall_arrayref( "
                SELECT g.* 
                FROM struct_5170_good g
                INNER JOIN struct_5170_good_param gp ON gp.good_id = g.good_id
                WHERE " . join( ' AND ', @w ) . "
                LIMIT ?,?
              ",
                { Slice => {} },
                @bind );
            if ( scalar @{$goods} ) {
                $goods = good_list_info($goods);
                &::mk_url( $goods, 'good' );
            }

            my $data = { goods => $goods,
                         q     => {
                          func=>$func,
                                bid => ( param('bid') || 0 ),
                                pid => ( param('pid') || 0 ),
                                page => $page,
                         } };
            &ans( $data, 200 );
        }

        sub podbor {
            
            $::params->{dbh}->do("SET NAMES cp1251");
            
            my $path_info = [ { header => 'Главная', href => '/' }, ];
            if(param('debug')){
                $ENV{HTTP_REFERER}='https://ekomag.com/catalog/104/1'
            }
            
            $ENV{HTTP_REFERER} =~ s/^https?:\/\/(.+)\.com//;
            $ENV{HTTP_REFERER} =~ s/\?.*$//;    
            my $url_from = url_from_conv($ENV{HTTP_REFERER});




                
            

            #if(param('debug')){
            #    &::print_header();
            #    &::pre($url_from);exit;
            #}

            my @w   = ('g.enabled=?');
            my @m_w = ('g.enabled=?');

            my @bind   = (1);
            my @m_bind = (1);
            my @brands = param('brand[]');


            my @w_not_brand=@w;
            my @bind_not_brand=@bind;

            if ( scalar @brands ) {
                push @w, 'g.brand_id in (' . join( ',', map {'?'} @brands ) . ')';
                @bind = ( @bind, @brands );

                push @m_w, 'g.brand_id in (' . join( ',', map {'?'} @brands ) . ')';
                @m_bind = ( @m_bind, @brands );
            }

            if ( param('min_price') && param('min_price') =~ /^(\d+)$/ ) {
                my $v=param('min_price');
                push @w, "p.price >= $v";
                push @w_not_brand,    "p.price >= $v";
                
            }

            if ( param('max_price') && param('max_price') =~ /^(\d+)$/ ) {
                push @w,    'p.price <= '.param('max_price');
                

                push @w_not_brand,    'p.price <= ?';
                push @bind_not_brand, param('max_price');
                
            }


            my ( $cid, $pid );
            if ( $url_from =~ /^\/(catalog)\/(.+)$/ ) {
                push @{$path_info},
                    { header => 'Каталог', href => '/catalog' };

                ( $cid, $pid ) = split( '/', $2 );
                $pid = int($pid);

                if ($cid) {
                    my $old_cid = $cid;
                    if ( $cid !~ /^(\d+)$/ ) { $cid = get_rub_id($cid); }
                    if ($cid) {
                        my $cur_rub = &::GET_DATA(
                                { struct => 'rubricator', onerow => 1, id => $cid } );
                        push @{$path_info},
                            { header => $cur_rub->{header},
                              href   => '/catalog/' . $old_cid };

                        push @w,      'g.rubricator_id = ?';
                        push @bind,   $cid;
                        push @m_w,    'g.rubricator_id =?';
                        push @m_bind, $cid;

                        push @w_not_brand,      'g.rubricator_id = ?';
                        push @bind_not_brand,   $cid;
                    }
                }

                if ($pid) {
                    my $old_pid = $pid;
                    if ( $pid !~ /^(\d+)$/ ) { $pid = get_pid($pid); }
                    if ($pid) {
                        my $tmp = &::GET_DATA( {  struct => 'params',
                                                where  => 'id=?',
                                                onerow => 1
                                             },
                                             $pid );
                        if ( $tmp->{parent_id} ) {
                            my $parent_pid = &::GET_DATA({struct=>'params',onerow=>1,id=>$tmp->{parent_id}});
                            @{$path_info} = ( 
                              @{$path_info}, 
                              { header => $parent_pid->{header}, href=>'/catalog/'.$cid.'/'.$tmp->{parent_id} },
                              { header => $tmp->{header}, href => '/catalog/'.$cid.'/'.$tmp->{parent_id}.'/'.$pid }
                            );

                            push @w,      'gp.param_id = ?';
                            push @bind,   $pid;

                            push @w_not_brand,      'gp.param_id = ?';
                            push @bind_not_brand,   $pid;

                            push @m_w,    'gp.param_id = ?';
                            push @m_bind, $pid;
                        }
                        else {
                            @{$path_info} = ( 
                              @{$path_info},                     
                              { header => $tmp->{header}, href => '/catalog/'.$cid.'/'.$pid }
                            );
                            my $c_pid =
                                $::params->{dbh}->selectall_arrayref(
                                "SELECT id FROM struct_5170_params WHERE parent_id = ?",
                                { Slice => {} },
                                $pid );
                            if ( $c_pid && scalar @{$c_pid} ) {
                                my @c_pids = map { $_->{id} } @{$c_pid};
                                @w = ( @w,
                                       '( gp.param_id = ? or gp.param_id in ('
                                           . join( ',', map {'?'} @c_pids ) . '))' );
                                @bind   = ( @bind,   $pid, @c_pids );

                                @w_not_brand=( @w_not_brand,
                                       '( gp.param_id = ? or gp.param_id in ('
                                           . join( ',', map {'?'} @c_pids ) . '))' );
                                @bind_not_brand   = ( @bind_not_brand,   $pid, @c_pids );


                                @m_w = ( @m_w,
                                         '( gp.param_id = ? or gp.param_id in ('
                                             . join( ',', map {'?'} @c_pids ) . '))'
                                );
                                
                                @m_bind = ( @m_bind, $pid, @c_pids );
                            }
                            else {
                                push @w,      'gp.param_id = ?';
                                push @bind,   $pid;
                                push @w_not_brand,      'gp.param_id = ?';
                                push @bind_not_brand,   $pid;

                                push @m_w,    'gp.param_id = ?';
                                push @m_bind, $pid;
                            }
                        }
                    }
                }

            }
            elsif ( $url_from =~ /^\/brand\/(.+)$/ ) {# && !scalar @brands ) {
                push @{$path_info}, { header => 'Бренды', href => '/brand'};
                my ($bid,$cid,$pid) = split('/',$1);      

                if ( $bid !~ /^(\d+)$/ ) { $bid = get_bid($bid); }
                if ( $cid && $cid !~ /^(\d+)$/ ) { $cid = get_rub_id($cid); }
                if ( $pid && $pid !~ /^(\d+)$/ ) {           
                  $pid = get_pid($pid); 
                }

                my $brand = &::GET_DATA({struct=>'brand',onerow=>1,id=>$bid});
                push @{$path_info}, { header => $brand->{header}, href => '/brand/' . $bid };

                if ( $cid ){
                  unless ( scalar @brands ) {
                    push @w,      'g.brand_id=?';
                    push @bind,   $bid;
                    push @m_w,    'g.brand_id=?';
                    push @m_bind, $bid;
                  }
                  my $cur_rub = &::GET_DATA({struct=>'rubricator',onerow=>1,id=>$cid});
                  push @{$path_info}, { header => $cur_rub->{header}, href => $path_info->[2]->{href}.'/'.$cid };

                  if ( $pid ){
                    my $tmp = &::GET_DATA({struct=>'params',onerow=>1,id=>$pid });
                    if ( $tmp->{parent_id} ){
                      my $pid_parent = &::GET_DATA({struct=>'params',onerow=>1,id=>$tmp->{parent_id}});
                      push @{$path_info}, { header => $pid_parent->{header}, href => $path_info->[3]->{href}.'/'.$tmp->{parent_id} };
                      push @{$path_info}, { header => $tmp->{header}, href => $path_info->[3]->{href}.'/'.$pid };
                      @w      = ( @w,      'g.rubricator_id = ? and gp.param_id = ?' );
                      @bind   = ( @bind,   $cid, $pid );
                      @m_w    = ( @m_w,    'g.rubricator_id = ? and gp.param_id = ?' );
                      @m_bind = ( @m_bind, $cid, $pid );
                    }
                    else{
                      push @{$path_info}, { header => $tmp->{header}, href => $path_info->[3]->{href}.'/'.$tmp->{id} };
                      my $c_pid =
                        $::params->{dbh}->selectall_arrayref(
                          "SELECT id FROM struct_5170_params WHERE parent_id = ?",
                          { Slice => {} },
                          $pid );
                      if ( $c_pid && scalar @{$c_pid} ) {
                        my @c_pids = map { $_->{id} } @{$c_pid};
                        @w = ( @w,
                          '( gp.param_id = ? or gp.param_id in ('
                            . join( ',', map {'?'} @c_pids ) . '))' );
                        @m_w = ( @m_w,
                          '( gp.param_id = ? or gp.param_id in ('
                            . join( ',', map {'?'} @c_pids ) . '))'
                        );
                       
                        @bind   = ( @bind,   $pid, @c_pids );
                        @m_bind = ( @m_bind, $pid, @c_pids );
                      }
                      else {
                        push @w,      'gp.param_id = ?';
                        push @m_w,    'gp.param_id = ?';
                        push @bind,   $pid;
                        push @m_bind, $pid;
                      }
                    }
                  }
                  else {
                    push @w,      'g.rubricator_id = ?';
                    push @bind,   $cid;
                    push @m_w,    'g.rubricator_id = ?';
                    push @m_bind, $cid;
                  }
                }
                else {
                  push @w,      'g.brand_id = ?';
                  push @bind,   $bid;
                  push @m_w,    'g.brand_id = ?';
                  push @m_bind, $bid;
                }
                @bind_not_brand=@bind; @w_not_brand=@w;
            }    

            my $m_sql = "
            SELECT min(p.price) min, max(p.price) max
            FROM struct_5170_good g
            JOIN struct_5170_good_prices p ON g.good_id = p.good_id
            INNER JOIN struct_5170_good_param gp ON gp.good_id = g.good_id
            WHERE " . join( ' AND ', @m_w );

            my $min_max_price
                = $::params->{dbh}->selectrow_hashref( $m_sql, undef, @m_bind );
            ( $tv->{PODBOR}{minPrice}, $tv->{PODBOR}{maxPrice}, $tv->{PODBOR}{min_price}, $tv->{PODBOR}{max_price} ) 
                = ( $min_max_price->{min}, $min_max_price->{max}, param('min_price'), param('max_price') );



            my $brands_have;
            {
              $brands_have = 
              $::params->{dbh}->selectall_arrayref(
                "
                    SELECT DISTINCT g.brand_id bid
                    FROM struct_5170_good g            
                    JOIN struct_5170_good_prices p ON p.good_id = g.good_id
                    INNER JOIN struct_5170_good_param gp ON gp.good_id = g.good_id
                    WHERE " . join( ' AND ', @w_not_brand ) . "
                    GROUP BY g.good_id
                ",
                {Slice=>{}},
                @bind_not_brand
              );

           }
            my @brands_have_ids = map { $_->{bid} } @{$brands_have};

            my $limit = 10;
            my $page  = param('page') && param('page') =~ /^(\d+)$/ ? $1 : 1;
            my $start = ( $page - 1 ) * $limit;

            @bind = ( @bind, $start, $limit );

            my $sql = "
              SELECT SQL_CALC_FOUND_ROWS g.*,g.good_id as id, if ( ie.in_url is not null, ie.ext_url, concat('/good/',g.good_id)) as url
              FROM struct_5170_good g
              LEFT JOIN in_ext_url ie ON ie.project_id = 5170 and ie.in_url = concat('/good/',g.good_id)
              JOIN struct_5170_good_prices p ON p.good_id = g.good_id
              INNER JOIN struct_5170_good_param gp ON gp.good_id = g.good_id      
              WHERE " . join( ' AND ', @w ) . "
              GROUP BY g.good_id
              LIMIT ?,?
            ";

            my $goods
                = $::params->{dbh}->selectall_arrayref( $sql, { Slice => {} }, @bind );
            #if(param('debug')){
            #    &::pre($goods);
            #    exit;
            #}
            my $total =
                $::params->{dbh}->selectrow_hashref(
                        "SELECT FOUND_ROWS() as total, CEIL(FOUND_ROWS()/?) as pages",
                        undef, ($limit) );

            if ( scalar @{$goods} ) {
                $goods = good_list_info($goods);
            }
            
            if($cid){ # получаем title
              # my $p1 = &::GET_DATA( {  struct => 'rubricator',
              #                        onerow => 1,
              #                        where  => 'rubricator_id=?'
              #                     },
              #                     $cid );
              # &::GET_DATA({
              #   select_fields=>'promo_title title, promo_description description, promo_keywords keywords',
              #   table=>'promo',
              #   to_tmpl=>'promo',
              #   onerow=>1,
              #   where=>'url=?'
              # },$url_from);

               
              # );
              unless($tv->{promo}{title}){
                if($pid){
                  $tv->{content} = &::GET_DATA({struct=>'params',id=>$pid,onerow=>1});
                }
                elsif($cid){
                  $tv->{content} = &::GET_DATA(
                         { where => 'enabled=1', struct => 'rubricator', onerow => 1, id => $cid }
                  )
                 
                }
                 $tv->{promo}{title} ="$tv->{content}->{header} - ЭКОМАГ. Магазин экологически чистых товаров",
              }

              if(param('debug')){
                &::pre([$cid,$pid,$tv->{promo}]); exit;
              }
              $tv->{promo}{description}
                  = sprintf(
                  "На нашем сайте  вы можете купить %s - %s в  Ростове-на-Дону",
                  ( $tv->{content}{header}, ( $p1->{h1} || $p1->{header} ) ) )
                  unless $tv->{promo}{description};

            }
            my $data = {
                q => {
                    from => $url_from,
                    minPrice => $tv->{PODBOR}{min_price},
                    maxPrice => $tv->{PODBOR}{max_price},
                    brands   => \@brands,
                    func=>$func
                    #     sql => $sql,
                    #     bind => \@bind,
                },
                podbor => $tv->{PODBOR},
                data   => {
                    brands_in => \@brands_have_ids,
                    path_info => $path_info,            
                    goods => $goods,
                    page  => $page,
                    pages => $total->{pages},
                    total => $total->{total},
                    title=>"$tv->{promo}{title}"
                } };

            &ans( $data, 200 );
            $::params->{stop}=1;
        }

        sub get_bid {
            my $in = @_;
            my $tmp = $::params->{dbh}->selectrow_hashref(
                "SELECT REPLACE(in_url,'/brand/','') as id
                 FROM in_ext_url WHERE project_id = 5170 AND ext_url = ?
                 LIMIT 1",
                undef,
                ( sprintf( "/brand/%s", $in ) ) );
            return $tmp->{id};
        }

        sub get_rub_id {
            my $in = @_;
            #pre({in=>$in});
            my $tmp = $::params->{dbh}->selectrow_hashref(
                "SELECT REPLACE(in_url,'/catalog/','') as id
                 FROM in_ext_url WHERE project_id = 5170 AND ext_url = ?
                 LIMIT 1",
                undef,
                "/catalog/$in"
        #        ( sprintf( "/catalog/%s", $in ) ) 
        );

            return $tmp->{id};
        }

        sub get_pid {
            my $in = @_;  
            my $tmp =
                $::params->{dbh}->selectrow_hashref(
                                    "SELECT id FROM struct_5170_params WHERE url = ?",
                                    undef, $in );
            return $tmp->{id};
        }

        sub good_list_info {
            my ($rows) = @_;
            my @gids = map { $_->{good_id} } @{$rows};

            my $certs = &::GET_DATA( {  table => 'struct_5170_good_cert',
                                      where => 'good_id in ( '
                                          . join( ',', map {'?'} @gids ) . ' )',
                                   },
                                   @gids );
            my @add_where=();

            my $WHERE='good_id in ( '. join( ',', map {'?'} @gids ) . ' )';
            my $v=param('max_price');

            if($v && $v=~m{^\d+$}){
                push @add_where,qq{price<=$v}
            }
            $v=param('min_price');
            if($v && $v=~m{^\d+$}){
                push @add_where,qq{price>=$v}

            }

            if(scalar(@add_where)){
                $WHERE .= 'AND ('.join(' AND ',@add_where).' )';

            }

            my $prices = &::GET_DATA( {  table => 'struct_5170_good_prices',
                                       where => $WHERE,
                                    },
                                    @gids );

            for my $price ( @{$prices} ) {
                $price->{in_bsk} = 0;
            }

            if ( scalar @{ $tv->{basket}{basket}{LIST} } ) {
                for my $price ( @{$prices} ) {
                    $price->{in_bsk} = map {1} grep {
                        $_->{good_id} == $price->{good_id}
                            && $_->{good_attr}{pid} == $price->{id}
                    } @{ $tv->{basket}{basket}{LIST} };
                }
            }

            for my $item ( @{$rows} ) {
                $item->{brand} = $brand->{ $item->{brand_id} };
                $item->{cert}
                    = [ grep { $_->{good_id} == $item->{good_id} } @{$certs} ];
                $item->{prices}
                    = [ grep { $_->{good_id} == $item->{good_id} } @{$prices} ];
                if ($fav_list) {
                    $item->{in_fav} = $fav_list->{ $item->{good_id} }{fav};
                }
                if ( $item->{photo} =~ /^(.+)\.(\w+)$/ ) {
                    my ( $name, $ext ) = ( $1, $2 );
                    for my $ind ( 1 .. 6 ) {
                        $item->{"photo_and_path_mini$ind"}
                            = sprintf( '/files/project_5170/good/%s_mini%d.%s',
                                       ( $name, $ind, $ext ) );
                    }
                }
            }
            return $rows;
        }

        sub good_info {
            my ($item) = @_;

            if ($fav_list) {
                $item->{in_fav} = $fav_list->{ $item->{good_id} }{fav};
            }

            $item->{brand} = $brand->{ $item->{brand_id} };

            $item->{cert} = &::GET_DATA( {  table => 'struct_5170_good_cert',
                                          where => 'good_id = ?'
                                       },
                                       $item->{good_id} );

            if ( $item->{photo} =~ /^(.+)\.(\w+)$/ ) {
                my ( $name, $ext ) = ( $1, $2 );
                for my $ind ( 1 .. 6 ) {
                    $item->{"photo_and_path_mini$ind"}
                        = sprintf( '/files/project_5170/good/%s_mini%d.%s',
                                   ( $name, $ind, $ext ) );
                }
            }

            $item->{prices} =
                $::params->{dbh}->selectall_arrayref(
                            "SELECT * FROM struct_5170_good_prices WHERE good_id = ?",
                            { Slice => {} },
                            $item->{id} );

            return $item;
        }

        # Добавляем товар в избраное
        sub add2fav {
            if ( $tv->{user}{is_auth} == 1 && $tv->{user}{user_id} eq param('uid') ) {
                if ( param('gid') =~ /^(\d+)$/ ) {
                    my $gid = $1;
                    my @v = ( $tv->{user}{user_id}, $gid );
                    unless ( $good = &::GET_DATA( { table  => 'struct_5170_user_fav',
                                                  onerow => 1,
                                                  where  => 'user_id=? and good_id=?'
                                                },
                                                @v ) )
                    {
                        $::params->{dbh}->do(
                            "INSERT INTO struct_5170_user_fav(user_id,good_id) VALUES(?,?)",
                            undef, @v );
                        &ans( { msg =>
                                    'Товар добавлен в избраное'
                              },
                              200 );
                    }
                    else {
                        &ans( { msg => 'Товар уже в избранном' },
                              200 );
                    }

                }
            }
            else {
                &ans( { msg => 'Необходима авторизация' }, 401 );
            }
        }

        sub del_from_fav {
            if ( $tv->{user}{is_auth} == 1 && $tv->{user}{user_id} eq param('uid') ) {
                if ( param('gid') =~ /^(\d+)$/ ) {
                    my $gid = $1;
                    my @v = ( $tv->{user}{user_id}, $gid );
                    if ( $good = &::GET_DATA( { table  => 'struct_5170_user_fav',
                                              onerow => 1,
                                              where  => 'user_id = ? and good_id = ?'
                                            },
                                            @v ) )
                    {
                        $::params->{dbh}->do(
                            "DELETE FROM struct_5170_user_fav WHERE user_id = ? and good_id = ?",
                            undef, @v );
                        &ans(
                            {  msg =>
                                   'Товар удален из избранного'
                            },
                            200 );
                    }
                    else {
                        &ans( { msg => 'Товара нет в избранном' },
                              200 );
                    }
                }
            }
            else {
                ans( { msg => 'Необходима авторизация' }, 401 );
            }
        }

        # Бок
        sub get_BskInfo {
            $tv->{page_type} = 'ajax';
            $tv->{bskinfo}   = 1;

        }

        # Инфа для быстрого просмотра
        sub get_goodInfo {
            if ( param('gid') =~ /^(\d+)$/ ) {
                my $gid = $1;   

                #&::print_header();

                #&ans({msg=>'good info in process'});
                $tv->{page_type} = 'ajax';
                $dbh->do("SET NAMES cp1251");
                $tv->{content}
                    = &::GET_DATA( { struct => 'good', id => $gid, onerow => 1 } );

                $tv->{prices} =
                $::params->{dbh}->selectall_arrayref(
                            "SELECT * FROM struct_5170_good_prices WHERE good_id = ?",
                            { Slice => {} }, $gid );
                $tv->{brand} = &::GET_DATA( {  struct => 'brand',
                                             where  => 'id=?',
                                             onerow => 1
                                          },
                                          $tv->{content}{brand_id} );
                $tv->{brand}{url}
                    = url_from_conv( '/brand/' . $tv->{content}{brand_id} );
                $tv->{fastgood} = 1;
                $tv->{content}{url} = url_from_conv( '/good/' . $gid );
            }
            else { &ans( { msg => 'Good id is not defined' } ); }
        }

        sub login {
            my $data = { msg    => 'Вы ввели неверные данные',
                         status => '401' };
            my $status = 200;
            if ( param('email') && param('password') ) {
                if ( my $user = &::GET_DATA( { struct => 'user',
                                             where  => 'email=? and password=?',
                                             onerow => 1
                                           },
                                           ( param('email'), param('password') ) ) )
                {
                    $data = { msg => 'Success', status => 200 };
                }

            }
            ans( $data, $status );
        }

        sub ans {
            my ( $data, $status ) = @_;
            $status = 404 unless $status;
            $data = { msg => 'Page not found', status => 404 } unless $data;
            #print header( -type    => 'application/json',
            #              -status  => $status,
            #              -charset => 'windows-1251' );
            print "Status: $status\nContent-type: application/json; charset=windows-1251\n\n";
            print $json->encode($data);
            &::end();
            return;
        }
}

sub catalog{

            my $conn_type = $1;
            my $rid = $6 || $4 || $2;
            my $pid = $3;
            #&::pre([$pid,$rid]) if(param('debug'));
            my $tv      = $::params->{TMPL_VARS};

            if ( $rid =~ /^(\d+)/ ) { 
                $rid = $1; 
                
            }
            elsif ($rid) {
                my $bbbb = sprintf( "/%s/%s", ( 'catalog', $rid ) );
                my $tmp = $::params->{dbh}->selectrow_hashref(
                    "SELECT REPLACE(in_url,'/catalog/','') as id 
                    FROM in_ext_url 
                    WHERE project_id=5170 and ext_url = ?",
                    undef,
                    $bbbb );
                if ($tmp) {
                    $rid = $tmp->{id};
                }

            }

            #$tv->{ON_RUB}->{$rid}=1;
            $tv->{RID}=$rid;
            my $brands_have;
            if ( $pid !~ /^(\d+)$/ ) {
                $pid = &::GET_DATA( {  struct        => 'params',
                                     onevalue      => 1,
                                     select_fields => 'id',
                                     where         => 'url=?',
                                  },
                                  $pid );

            }
                #&::pre({pid=>$pid,}) if(param('debug'));
            $tv->{ON_RUB}->{$pid}=1;



            
            my $tbl     = 'rubricator';
            my $url     = 'catalog';
            my $par_perpage=param('perpage');

            if($par_perpage=~m{^\d+$} && $par_perpage<=100){
              $tv->{cur_perpage}=$par_perpage;
              $tv->{const}->{good_perpage}=$par_perpage;
            }
            my $perpage = param('show') eq 'all' ? undef : $tv->{const}->{good_perpage};

            $perpage = undef if $conn_type eq 'acatalog';
            $tv->{conn_type} = $conn_type;

            &::GET_DATA( {  table   => 'content',
                          to_tmpl => 'info',
                          where   => 'url=?',
                          onerow  => 1
                       },
                       '/catalog' );
            
            if ( $rid =~ m/^\d+$/ ) {   # выбран раздел рубрикатора
                $tv->{content} = &::GET_DATA(
                         { where => 'enabled=1', struct => $tbl, onerow => 1, id => $rid }
                     );

                if ( $tv->{content})
                {
                    

                    my @cp_w = ( 'g.enabled=?', 'r.enabled=? AND r.parent_id is null' );
                    my @cp_bind = ( 1, 1 );

                    if ( $pid =~ /^(\d+)$/ ){
                        &::GET_DATA({struct=>'params',to_tmpl=>'CUR_PID',onerow=>1,where=>'id=?'},$pid);
                        $tv->{ON_RUB}->{$tv->{CUR_PID}->{parent_id}}=1 if($tv->{CUR_PID}->{parent_id} );
                        $tv->{ON_RUB}->{$tv->{CUR_PID}->{parent_uid}}=1 if($tv->{CUR_PID}->{parent_uid});
                    }

                    $tv->{CATALOG_PODBOR_TMP} = $::params->{dbh}->selectall_arrayref( "
                        SELECT r.*,r.rubricator_id id, if( ie.in_url is not null,ie.ext_url,concat('/catalog/',r.rubricator_id)) as url
                        FROM struct_5170_rubricator r
                        LEFT JOIN in_ext_url ie ON ie.project_id = 5170 and ie.in_url = concat('/catalog/',r.rubricator_id)
                        JOIN struct_5170_good g ON g.rubricator_id = r.rubricator_id
                        WHERE " . join( ' AND ', @cp_w ) . "
                        GROUP BY r.rubricator_id
                        ",
                        { Slice => {} },
                        @cp_bind );

                    for my $item ( @{ $tv->{CATALOG_PODBOR} } ) {
                        $item->{act} = 0;
                        if ( $rid == $item->{rubricator_id} ) {
                            $item->{act} = 1;
                        }

                        my $child = $::params->{dbh}->selectall_arrayref( "
                            SELECT p.*,p.id,0 as act,concat('/catalog/',g.rubricator_id,'/',if(p.url <> '',p.url,p.id)) as url
                            FROM struct_5170_good g
                            INNER JOIN struct_5170_good_param gp ON gp.good_id = g.good_id
                            INNER JOIN struct_5170_params p ON p.id = gp.param_id
                            WHERE g.enabled = 1 and g.rubricator_id = ?
                            GROUP by p.id
                            ",
                            { Slice => {} },
                            ( $item->{id} ) );

                        my @p_ids = map { $_->{parent_id} }
                            grep { $_->{parent_id} && $_->{parent_id} != 0 } @{$child};
                            
                        @p_ids = ( @p_ids,
                                   map { $_->{id} }
                                       grep { !$_->{parent_id} || $_->{parent_id} == 0 }
                                       @{$child} );
                                       
                        next unless scalar @p_ids;            

                        $item->{child} = $::params->{dbh}->selectall_arrayref( "
                                SELECT *,0 as act, id,concat('/catalog/',?,'/', if ( url <> '', url, id )) as url
                                FROM struct_5170_params
                                WHERE id in (" . join( ',', map {'?'} @p_ids ) . ")
                            ",
                            { Slice => {} },
                            ( $item->{id}, @p_ids ) );

                        for my $tmp ( @{ $item->{child} } ) {               

                            if ( $tv->{CUR_PID} ){
                                $tmp->{act} = !$tv->{CUR_PID}{parent_id} ? ( $tv->{CUR_PID}{id} == $tmp->{id} ? 1 : 0 ) : ( $tv->{CUR_PID}{parent_id} == $tmp->{id} ? 1 : 0 );
                            }
                            $tmp->{child} = [ grep { $_->{parent_id} == $tmp->{id} } @{$child} ];
                            for my $tmp2 ( @{$tmp->{child}} ){
                                $tmp2->{act} = 0;
                                if ( !$tv->{CUR_PID}{parent_id} ){ $tmp2->{act} = $tv->{CUR_PID}{id} == $tmp2->{id} ? 1 : 0; }
                                else {
                                    $tmp2->{act} = 0;
                                }
                            }
                        }
                    }

                    $tv->{page_type} = 'catalog/spisok';

                    $tv->{LSIDE_CLS} = 'side_2';
                    $tv->{LSIDE}     = ['PODBOR'];

                    my @mm_w    = ( 'g.enabled=?', 'g.rubricator_id=?' );
                    my @mm_bind = ( 1,             $rid );

                    if ( $pid =~ /^(\d+)$/ ) {
                        @mm_w    = ( @mm_w,    'gp.param_id = ?' );
                        @mm_bind = ( @mm_bind, $pid );
                        if ( !$tv->{CUR_PID}{parent_id} ){
                            my $c_pids = $::params->{dbh}->selectall_arrayref("SELECT id FROM struct_5170_params WHERE parent_id = ?",{Slice=>{}},$tv->{CUR_PID}{id});
                            my @c_pids_arr = map { $_->{id} } @{$c_pids};
                            @mm_w = ( @mm_w, 'gp.param_id in (' . join(',', map { '?' } @c_pids_arr ) . ')' );
                            @mm_bind = ( @mm_bind, @c_pids_arr );
                        }
                    }
                    my $min_max_price = $::params->{dbh}->selectrow_hashref( "
                        SELECT min(p.price) min, max(p.price) max
                        FROM struct_5170_good g
                        INNER JOIN struct_5170_good_prices p ON g.good_id = p.good_id
                        "
                            . (
                            $pid =~ /^(\d+)$/
                            ? " INNER JOIN struct_5170_good_param gp ON gp.good_id = g.good_id "
                            : ""
                            )
                            . "
                        WHERE " . join( ' AND ', @mm_w ) . "
                    ", undef,
                        @mm_bind );

                    ( $tv->{PODBOR}{min_price}, $tv->{PODBOR}{max_price} )
                        = ( $min_max_price->{min}, $min_max_price->{max} );
                    ( $tv->{content}{min_price}, $tv->{content}{max_price} )
                        = ( $min_max_price->{min}, $min_max_price->{max} );

                    my @w = ( 'r.enabled=?', 'r.rubricator_id=?', 'g.enabled=?' );
                    my @bind = ( 1, $rid, 1 );

                    if ( $pid =~ /^(\d+)$/ ) {
                        #if(param('debug')){
                         #     &::pre({pid=>$pid,par=>$tv->{CUR_PID}{parent_id}});
                        #}
                        if ( !$tv->{CUR_PID}{parent_id} ){
                            my $c_pids = $::params->{dbh}->selectall_arrayref("SELECT id FROM struct_5170_params WHERE parent_id = ?",{Slice=>{}},$tv->{CUR_PID}{id});

                            my @c_pids_arr = map { $_->{id} } @{$c_pids};
                            @w = ( @w, '( gp.param_id = ? or gp.param_id in (' . join(',', map { '?' } @c_pids_arr ) . ') )' );
                            @bind = ( @bind, $pid, @c_pids_arr );
                        }
                        else {
                            @w =( @w, 'gp.param_id = ?');
                            @bind = ( @bind, $pid );
                        }
                    }
                    
                    if ( param('min_price') && param('min_price') =~ /^(\d+)$/ ){
                        @w = ( @w, 'p.price >= ?' );
                        @bind = ( @bind, $1 );
                    }
                    if ( param('max_price') && param('max_price') =~ /^(\d+)$/ ){
                        @w = ( @w, 'p.price <= ?' );
                        @bind = ( @bind, $1 );
                    }

                    my $sql = "
                            SELECT SQL_CALC_FOUND_ROWS
                            g.*, g.good_id as id, if (ie.in_url is not null,ie.ext_url,concat('/good/',g.good_id)) as url
                        FROM struct_5170_rubricator r           
                        INNER JOIN struct_5170_good g ON g.rubricator_id = r.rubricator_id 
                        JOIN struct_5170_good_prices p ON g.good_id = p.good_id
                        LEFT JOIN in_ext_url ie ON ie.project_id = 5170 and ie.in_url = concat('/good/',g.good_id) "
                        . ( $pid =~ /^(\d+)$/
                        ? " INNER JOIN struct_5170_good_param gp ON gp.good_id = g.good_id "
                        : "" )
                        . "
                        WHERE " . join( ' AND ', @w ) . "
                        GROUP by g.good_id ORDER BY g.good_id desc ";
                        
                   $brands_have = {map {$_->{brand_id}=>1}
                    @{$::params->{dbh}->selectall_arrayref(
                        "
                            SELECT DISTINCT g.brand_id
                        FROM struct_5170_rubricator r           
                        INNER JOIN struct_5170_good g ON g.rubricator_id = r.rubricator_id 
                        JOIN struct_5170_good_prices p ON g.good_id = p.good_id
                        LEFT JOIN in_ext_url ie ON ie.project_id = 5170 and ie.in_url = concat('/good/',g.good_id) "
                        . ( $pid =~ /^(\d+)$/
                        ? " INNER JOIN struct_5170_good_param gp ON gp.good_id = g.good_id "
                        : "" )
                        . "
                        WHERE " . join( ' AND ', @w ) . "
                        GROUP by g.good_id ORDER BY g.good_id desc ",
                        {Slice=>{}},
                        @bind
                    )}};


                    if ($perpage) {
                        $sql .= " LIMIT ?,?";
                        my $page = ( $tv->{page} - 1 ) * $perpage;
                        @bind = ( @bind, $page, $perpage );
                    }       
                    
                    
                     #&pre($sql) if param('dev123');
                     #&pre(\@bind) if param('dev123');

                    $tv->{LIST} = $::params->{dbh}
                        ->selectall_arrayref( $sql, { Slice => {} }, @bind );
                    if ($perpage) {
                        $tv->{maxpage} = [ $::params->{dbh}->selectrow_arrayref(
                                                            "SELECT CEIL(FOUND_ROWS()/?)",
                                                            undef, $perpage
                                           )
                        ]->[0][0];
                    }

                    our $brand = $tv->{BRANDS};

                    our $fav_list;
                    if ( $tv->{user}{is_auth} == 1 ) {
                        $fav_list =
                            $::params->{dbh}->selectall_hashref(
                            "SELECT good_id, 1 as fav FROM struct_5170_user_fav WHERE user_id = ?",
                            "good_id", undef, $tv->{user}{user_id} );
                    }

                    if ( scalar( @{ $tv->{LIST} } ) ) {
                        $tv->{LIST} = &good_list_info( $tv->{LIST} );
                    }

                    my $page = param('page');
                    if ( $page && $page > 1 && scalar( @{ $tv->{LIST} } ) <= 0 ) {
                        $tv->{page_type} = undef;
                    }

                    &::GET_PATH( { struct      => $tbl,
                                 id          => $rid,
                                 to_tmpl     => 'PATH_INFO',
                                 create_href => '/catalog/[%id%]'
                               } );

                    if ( scalar( @{ $tv->{PATH_INFO} } ) >= 2 ) {
                        my $p1 = &::GET_DATA( {  struct => 'rubricator',
                                               onerow => 1,
                                               where  => 'rubricator_id=?'
                                            },
                                            $tv->{PATH_INFO}[0]{id} );
                        $tv->{promo}{title} =
                            sprintf( "%s - %s в Ростове-на-Дону",
                                     (  $tv->{content}{header},
                                        ( $p1->{h1} || $p1->{header} )
                                     )
                            ) unless $tv->{promo}{title};
                        $tv->{promo}{description}
                            = sprintf(
                            "На нашем сайте  вы можете купить %s - %s в  Ростове-на-Дону",
                            ( $tv->{content}{header}, ( $p1->{h1} || $p1->{header} ) ) )
                            unless $tv->{promo}{description};
                    }

                    if ( $pid =~ /^(\d+)$/ ) {
                        &::GET_DATA( { struct  => 'params',
                                     id      => $pid,
                                     onerow  => 1,
                                     to_tmpl => 'content'
                                   } );
                        if ( $tv->{content}{parent_id} ) {
                            my $parent = &::GET_DATA( { struct => 'params',
                                                      id     => $tv->{content}{parent_id},
                                                      onerow => 1
                                                    } );
                            push @{ $tv->{PATH_INFO} },
                                { header => $parent->{header},
                                  href   => '/catalog/' . $rid . '/' . $parent->{id} };
                            push @{ $tv->{PATH_INFO} },
                                { header => $tv->{content}{header},
                                  href   => '/catalog/'
                                      . $rid . '/'
                                      . $parent->{id} . '/'
                                      . $pid };
                        }
                        else {
                            push @{ $tv->{PATH_INFO} },
                                { header => $tv->{content}{header},
                                  href   => '/catalog/' . $rid . '/' . $pid };
                        }
                    }

                    $tv->{page} = undef unless ( param('page') <= $tv->{maxpage} );
                   
                }
            }
            elsif ( $ENV{PATH_INFO} eq '/catalog' ||  $ENV{PATH_INFO} eq '/xcatalog') {
                $tv->{page_type} = 'catalog/catalog';

                &::GET_DATA( { struct  => $tbl,
                             to_tmpl => 'LIST1',
                             where   => 'enabled=1 AND path=""',
                             order   => 'sort',
                           } );

                my @rids = map { $_->{id} } @{ $tv->{LIST1} };

                my $tmp = $::params->{dbh}->selectall_hashref( "
                    SELECT rubricator_id as id, count(*) as cnt
                    FROM struct_5170_good
                    WHERE enabled=1 and rubricator_id in ( "
                        . join( ',', map {'?'} @rids ) . " )
                    GROUP BY rubricator_id
                ",
                    "id",
                    undef,
                    @rids );

                foreach my $rub ( @{ $tv->{LIST1} } ) {
                    $rub->{goods} = $tmp->{ $rub->{id} }{cnt};
                }

                
                $tv->{LIST}
                    = [ grep { $_->{goods} && $_->{goods} > 0 } @{ $tv->{LIST1} } ];
                &::mk_url( $tv->{LIST}, $url );

                $tv->{content} = $tv->{info};

                my $brand_on={map{$_->{brand_id}=>1} @{$tv->{LIST}}};

                foreach my $b (@{$tv->{BRANDS_PODBOR}}){
                    $b->{hide}=$brands_have->{$b->{id}}?0:1
                }
            }

            




            $tv->{promo}{title} = $tv->{content}{header} unless ( $tv->{promo}{title} );
            unshift @{ $tv->{PATH_INFO} },
                { header => $tv->{info}{header}, href => '/catalog' };

            sub good_list_info {
                my ($rows) = @_;
                my @gids = map { $_->{good_id} } @{$rows};

                my $certs = &::GET_DATA( {  table => 'struct_5170_good_cert',
                                          where => 'good_id in ( '
                                              . join( ',', map {'?'} @gids ) . ' )',
                                       },
                                       @gids );
                my $WHERE='good_id in ( '. join( ',', map {'?'} @gids ) . ' )';
                my $v=param('max_price');

                if($v && $v=~m{^\d+$}){
                    push @add_where,qq{price<=$v}
                }
                $v=param('min_price');
                if($v && $v=~m{^\d+$}){
                    push @add_where,qq{price>=$v}

                }

                if(scalar(@add_where)){
                    $WHERE .= 'AND ('.join(' AND ',@add_where).' )';

                }
                my $prices = &::GET_DATA( {  table => 'struct_5170_good_prices',
                                           where => $WHERE,
                                        },
                                        @gids );

                for my $price ( @{$prices} ) {
                    $price->{in_bsk} = 0;
                }

                if ( scalar @{ $tv->{basket}{basket}{LIST} } ) {
                    for my $price ( @{$prices} ) {
                        $price->{in_bsk} = map {1} grep {
                            $_->{good_id} == $price->{good_id}
                                && $_->{good_attr}{pid} == $price->{id}
                        } @{ $tv->{basket}{basket}{LIST} };
                    }
                }

                for my $item ( @{$rows} ) {
                    $item->{brand} = $brand->{ $item->{brand_id} };
                    $item->{cert}
                        = [ grep { $_->{good_id} == $item->{good_id} } @{$certs} ];
                    $item->{prices}
                        = [ grep { $_->{good_id} == $item->{good_id} } @{$prices} ];
                    if ($fav_list) {
                        $item->{in_fav} = $fav_list->{ $item->{good_id} }{fav};
                    }
                    if ( $item->{photo} =~ /^(.+)\.(\w+)$/ ) {
                        my ( $name, $ext ) = ( $1, $2 );
                        for my $ind ( 1 .. 6 ) {
                            $item->{"photo_and_path_mini$ind"}
                                = sprintf( '/files/project_5170/good/%s_mini%d.%s',
                                           ( $name, $ind, $ext ) );
                        }
                    }
                }
                return $rows;
            }


}
sub url_from_conv{
    my $url_from=shift;
    $url_from=~s{\/brand\/\d+}{\/catalog};

    my $change_ok=0;
    if($url_from=~m{\/(a?catalog)\/(.+?)\/(.+?)$}){ # преобразуем ЧПУ

        my $url1=qq{/$1/$2};
        my $url2="/$3";
        my $sth=$::params->{dbh}->prepare("SELECT in_url from in_ext_url where ext_url=? and project_id=?");
        $sth->execute($url1,$::params->{project}->{project_id});
        if(my $url1_1=$sth->fetchrow()){
            $url_from=qq{$url1_1$url2};
            $change_ok=1
        }
    }
    if(!$change_ok){
        my $sth=$::params->{dbh}->prepare("SELECT in_url from in_ext_url where ext_url=? and project_id=?");
        $sth->execute($url_from,$::params->{project}->{project_id});
        if(my $new_url=$sth->fetchrow){
            $url_from=$new_url;
        }
    }

    return $url_from
}
return 1;