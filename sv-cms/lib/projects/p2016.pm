package p2016;
use CGI qw/param/;
use strict;

sub basketprocess{
    my $tv=$::params->{TMPL_VARS}; my $dbh=$::params->{dbh};
    my $comfort = $dbh->selectall_hashref("SELECT * FROM struct_2016_comfort_level", "id");
    my $spring_block = $dbh->selectall_hashref("SELECT * FROM struct_2016_spring_block", "id");
    my $dimensons = $dbh->selectall_hashref("SELECT * FROM struct_2016_dimensions", "id");
    $tv->{CITIES} = &::GET_DATA({ struct=>'cities', tree_use=>0, order=>'sort asc', });

    $tv->{total_sum} = 0;
    
    foreach my $element ( @{$tv->{BASKET}} ) {
        my $g=$dbh->selectrow_hashref(
            qq{
                SELECT
                    g.good_id, g.header, g.body, g.hit, g.legend_group_id, g.new, g.artikul, g.rubricator_id, g.photo, g.manufacturer, g.spring, g.comfort, g.height, a.good_id as myid, a.price, a.price2
                FROM
                    struct_2016_good g, struct_2016_good_attr a
                WHERE g.good_id=$element->{good_id} and g.good_id=a.good_id group by myid
                ORDER by a.price+0, a.price2+0
                LIMIT 1
            },
            {Slice=>{}}
        );
     
        $g->{price} =~ s/\s//is; $g->{price2} =~ s/\s//is;
      
        if ( $g->{photo}=~m/^(.+)\.([^\.]+)$/ ){ 
            my ($name,$ext) = ($1,$2);
            $g->{photo_and_path}=qq{/files/project_2016/good/$name.$ext};
            $g->{photo_and_path_mini1}=qq{/files/project_2016/good/$name\_mini1.$ext};
        }
      
        $g->{comfort_text} = $comfort->{$g->{comfort}}->{header};
        $g->{comfort_photo} = '/files/project_2016/news/'.$comfort->{$g->{comfort}}->{photo};
        $g->{spring_text} = $spring_block->{$g->{spring}}->{header};
      
        #говнокод. потом поправить запрос выше, $g= ....
        $g->{attr} = $dbh->selectall_arrayref("SELECT * FROM struct_2016_good_attr WHERE id=$element->{size} limit 1",{Slice=>{}});
        $g->{obivka_list} = &::GET_DATA({struct=>'obivka',where=>'id in (SELECT obivka_id FROM struct_2016_good_obivka WHERE good_id = ? )'},$g->{good_id});
        foreach my $a ( @{ $g->{attr} } ) {
            #хак (это потом убрать)
            #внедряем правильную цену заодно
            $g->{price} = $a->{price};
            $g->{price2} = $a->{price2};
    
            $g->{price} =~ s/\s//is; $g->{price2} =~ s/\s//is;
    
            $a->{dimensions_text} = $$dimensons{$$a{dimension}}{header};
            if ( $$dimensons{$$a{id}}{id} == $element->{size} ) {
                $element->{dimensions_text} = $$dimensons{$$a{dimension}}{header};
            }
        }
        if ( $g->{price2}>0 ){ 
            $g->{sum} = ($g->{price2}*$element->{cnt}); 
        } 
        else { 
            $g->{sum} = ($g->{price}*$element->{cnt}); 
        }
        $tv->{total_sum}+=$g->{sum};
        $element->{STRUCT} = $g;
    }

}

sub basket{
    my $tv=$::params->{TMPL_VARS}; my $dbh=$::params->{dbh};
    $tv->{promo}{title}='Корзина' unless($tv->{promo}{title});
    $tv->{page_type}= 'basketN';
    my $action=param('action');
    
    if($action ne 'form_send'){ # данные не отправлялись
      if($tv->{login_info} ){
        $tv->{form_vls}=$tv->{login_info}
      }
    }

    
    
    if ( $tv->{BASKET} ) {
        if ( scalar( @{ $tv->{BASKET} } ) > 0 ) {
            basketprocess();

               if ( $tv->{BASKETSTEP} == 2 ) {
                    basketstep2()
               }
               elsif ( $tv->{BASKETSTEP} == 3  && param('action') eq 'form_send' && param('type') eq 'order' ) {
                    basketstep3()

               }

        }
    }

}


sub basketstep3{
    my $tv=$::params->{TMPL_VARS}; my $dbh=$::params->{dbh};
    my $db = $dbh;
    my $form_status;
    my $str_key = param('capture_key');
    my $str = param('capture_str');     

    # Информация об условиях доставки шага 2
    my $pay = param('pay');
    my $usl_dost= param('usl_dost');
    my $city   = param('city');
    
    my $street     = param('ship_street');
    my $house  = param('ship_house');
    my $korp   = param('ship_korp'); 
    my $flat   = param('ship_flat');
    my $moreinfo   = param('moreinfo');
     #my $order_list;
    $city = 0 unless($city =~ m/\d+/ );

    my $message_for_zakaz;
     
    my $order_list = create_order_list($tv->{BASKET});
     
    my $paytype_text = $pay == 2 ? 'Безналичный расчет' : 'Наличными курьеру';
    my $paytype_text2 = $usl_dost == 2 ? 'По адресу' : 'Самовывоз';
    my $city_text;
    my $city_price;
    my $total_with_shipping;

    my $shipping_message =qq{       
       Способ оплаты: $paytype_text<br/>
       Способ доставки: $paytype_text2<br/>
     };
     
    my $total_with_shipping = $tv->{total_sum};

    if ( $city =~ /\d+/ && $usl_dost == 2 ) {
        my $x = &::GET_DATA({ struct=>'cities', where=>'rubricator_id=?', onerow=>1, }, $city);
        my $min_to_max_sum = $tv->{const}{pricedostavkamin};
        $city_text = $x->{header};
        my $city_price = $tv->{total_sum} > $min_to_max_sum ? $x->{shipping_max} : $x->{shipping_min};
        $total_with_shipping = sprintf("%.0f", $tv->{total_sum}+$city_price); 
        my @addr = ( $city_text, $street, $house, $korp, $flat );
        my $city_text_str = join(',',@addr);
        $shipping_message.=qq{
            <p>Информация о доставке:</p>
            Город доставки: $city_text_str<br/>
            Стоимость доставки: $city_price<br/>
        };
    }

    $shipping_message.=qq{<p><b>Итого вместе с доставкой: </b>$total_with_shipping руб.</p>};
    
    if ( $tv->{login_info} ) {
        my $moreinfo = param('moreinfo');
        $tv->{form_vls}{moreinfo} = $moreinfo;
        my $sth = $db->prepare(qq{SELECT count(*) from capture WHERE project_id=2016 and str_key="$str_key" and str="$str"});
        $sth->execute;   
       
        unless(my $r=$sth->fetchrow){
            $form_status = 'error';    
            $tv->{errors}{capture} = 'Код введён неверно.';
        }
        else {
            # в случае успешного заказа сохраняем информацию о нём в БД
            my $zakaz_id = &create_order({
                user_id=>($tv->{login_info}{id}||0),
                pay => $pay, usl_dost=>$usl_dost, city => $city, 
                street => $street, house => $house, korp => $korp, 
                flat => $flat, moreinfo => $moreinfo 
            });
            my ($email,$password);
            my ($adm_msg,$usr_msg) = &gen_msg($zakaz_id,$order_list,$tv->{total_sum},$tv->{form_vls},$shipping_message,$tv->{newuser},$email,$password);
            if( $zakaz_id ) {
                $tv->{zakaz_id} = $zakaz_id;
            } 
         
            &sendmessage({ address=>$tv->{const}{managerEmail}, message=>$adm_msg,subject=>$::params->{project}{domain}, });
          
            &sendmessage({ address=>$tv->{form_vls}{email}, message=>$usr_msg, subject=>$::params->{project}{domain},});
           
            &my_clearbasket;
       }
    }
    else {
        my $name  = $tv->{form_vls}{name}  = param('name');
        my $email = $tv->{form_vls}{email} = param('email');
        my $phone = $tv->{form_vls}{phone} = param('phone');
        my $moreinfo = $tv->{form_vls}{moreinfo}  = param('moreinfo');

        if( $name!~m/^[ \.а-яА-Я\w]+$/ ){
           $form_status = 'send_no';
           $tv->{errors}{name} = 'Поле ФИО заполнено неверно.';
        }
        if( $phone!~m/^[ +\(\)\-0-9]+$/ ){
           $form_status = 'send_no';
           $tv->{errors}{phone} = 'Поле Tелефон заполнено неверно.';
        }
        if( $email!~m/^[\_\.\-\w]+@[\_\.\-\w]+\.\w+$/ ){
           $form_status = 'send_no';
           $tv->{errors}{email} = 'Поле E-mail заполнено неверно.';
        }      
         
        #надо проверить нет ли такого емыла в базе
        my $check = &::GET_DATA({
            struct=>'user',
            where=>'email=?',
            onevalue=>1,
            select_fields=>'email'
        }, $email);

        if ( $check eq $email ) {
           $form_status = 'send_no';
           $tv->{errors}{email} = 'Пользователь с таким E-mail уже зарегистрирован.';
        }
        
        $moreinfo='' unless($moreinfo);
         
        my $sth = $db->prepare(qq{SELECT count(*) from capture WHERE project_id=2016 and str_key="$str_key" and str="$str"});
        $sth->execute; 
        
        unless (my $r=$sth->fetchrow){
           $form_status = 'send_no';    
           $tv->{errors}{capture} = 'Код введён неверно.';
        }
        my ($adm_msg,$usr_msg);
        if ( $form_status ne 'send_no' ) {
                my $pay     = param('pay');
                my $usl_dost    = param('usl_dost');
                my $city    = param('city');
                $city = 0 if ( $city !~ /\d+/ );
                my $street  = param('ship_street');
                my $house   = param('ship_house');
                my $korp    = param('ship_korp');
                my $flat    = param('ship_flat');
                my $moreinfo    = param('moreinfo');
        
                $tv->{newuser} = 1;
                my $password = genpassword();
        
                my $sth = $db->prepare("INSERT into struct_2016_user (email, password, name, phone) value (?, ?, ?, ? )");
                $sth->execute($email, $password, $name, $phone);
                my $new_user_id=$sth->{mysql_insertid};
        
                # в случае успешного заказа сохраняем информацию о нём в БД

                my $zakaz_id = create_order({
                    user_id=>($new_user_id||0),
                    pay => $pay, usl_dost=>$usl_dost, city => $city, 
                    street => $street, house => $house, korp => $korp, 
                    flat => $flat, moreinfo => $moreinfo 
                });
         
                ($adm_msg,$usr_msg) = gen_msg($zakaz_id,$order_list,$tv->{total_sum},$tv->{form_vls},$shipping_message,$tv->{newuser},$email,$password);

                
                $tv->{zakaz_id} = $zakaz_id if( $zakaz_id );

        }
        
        #письмо админу
        sendmessage({ address=>$tv->{const}{managerEmail}, subject=>$::params->{project}->{domain}, message=>$adm_msg, });
        
        #письмо юзеру
        sendmessage({ address=>$email, message=>$usr_msg, subject=>$::params->{project}->{domain}, });
        
        #контрольный выстрел в корзину
        my_clearbasket();
    }
    
    $tv->{form_status} = $form_status;
}




sub create_order_list {
  my ( $data ) = @_;
  my $rows;
  map {
    my $good = $_->{STRUCT};
    my $e = $_;
    if ( $good->{price} > 0 ){  
#      my $summ = $good->{price} * $good->{count};
      my $oh = &GET_DATA({struct=>'obivka',onevalue=>1,select_fields=>'header',where=>'id=?'},$e->{obivka});
      $oh = '-' unless $oh;
      my $price = $good->{price2} ? $good->{price2} : $good->{price};
      my $summ = $price * $e->{cnt};
      $rows .= qq{
        <tr>
          <td>$good->{header}</td>
          <td>@{$good->{attr}}[0]->{dimensions_text}</td>
          <td>$oh</td>
          <td>$price</td>
          <td>$e->{cnt}</td>
          <td>$summ</td>
        </tr>
      };
    }
  } @{$data};
  return $rows; 
}

sub genpassword {
    my $a='123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';                                                                                                        
    my $str='';      
    my $password;                                                                                                                                    
    
    foreach my $k (1..9){                                                                                                                                
        $str.=substr($a,int(rand(length($a))),1);
    }
    $password = $str;
    return $password;
}

sub sendmessage {

  my $p = shift;


        send_mes(
        {
            from => 'no-reply@'.$::params->{project}->{domain},
            to=>$p->{address},
            message=>$p->{message},
            subject=>'Сообщение с сайта http://'.$::params->{project}->{domain}.'/',
        });
}

sub my_clearbasket {

     my $name='basket';
     my $cookie=new CGI::Cookie(
                -name=>$name,
                -value=>[qq{{"data":[]}}]
     );
     $::params->{basket}->{$name}=(); 
     $::params->{TMPL_VARS}->{BASKET}={}; 
     print "Set-Cookie: $cookie\n";
    }

sub create_order {
  my ( $in ) = @_;
  my $dbh=$::params->{dbh}; my $tv=$::params->{TMPL_VARS};
  $dbh->do(
    "INSERT INTO struct_2016_zakaz(user_id,registered, paytype,shiptype,ship_city,ship_street,ship_house,ship_corpus,ship_flat, more_info) values(?,now(),?,?,?,?,?,?,?,?)",
    undef,
    ($in->{user_id}, $in->{pay}, $in->{usl_dost}, $in->{city}, $in->{street}, $in->{house}, $in->{korp}, $in->{flat}, $in->{moreinfo})
  );
  my $zakaz_id=$dbh->last_insert_id(undef,undef,'struct_2016_zakaz','id');
  map {
    $dbh->do(
      "INSERT INTO struct_2016_zakaz_info(zakaz_id,good_id,size,cnt,obivka) values(?,?,?,?,?)",
      undef,
      ($zakaz_id,$_->{good_id},$_->{size},$_->{cnt},$_->{obivka})
    );
  } @{$tv->{BASKET}};
  
  return $zakaz_id;
}

sub gen_msg {
  my ( $zakaz_id,$order_list,$total_sum,$form_vls,$shipping_message,$new_user,$email,$password) = @_;
  my $message_for_zakaz=qq{
    <p><b>Информация о заказе:</b></p>
    <table>
      <tr><td colspan='5'>Номер заказа: $zakaz_id</td></tr>
      <tr>
        <td>Наименование товара</td>
        <td>Размер</td>
        <td>Обивка</td>
        <td>Цена</td>
        <td>Количество</td>
        <td>Сумма</td>
      </tr>
      $order_list
    </table>
    <p><b>Итого: </b>$total_sum руб.</p>
  };
  
  my $message=qq{
    <style>td {border: 1px solid black;}</style>
    <p>Только что на сайте <a href="http://$::params->{project}->{domain}">http://$::params->{project}->{domain}</a> был сделан заказ.</p>
    <p>Информация о заказчике:</p>
    <table>
      <tr><td><b>Имя:</b></td><td>$form_vls->{name}</td></tr>
      <tr><td><b>Телефон:</b></td><td>$form_vls->{phone}</td></tr>
      <tr><td><b>Email:</b></td><td>$form_vls->{email}</td></tr>
      <tr><td><b>Доп. информация:</b></td><td>$form_vls->{moreinfo}</td></tr>
    </table>
    $message_for_zakaz
    <br />
    $shipping_message
  };
   
  my $user_message=qq{
    <style>td {border: 1px solid black;}</style>
    <p>Здравствуйте!</p>
    <p>Вы только что сделали заказ на сайте http://$::params->{project}->{domain}</p>
    $message_for_zakaz
    <br />
    $shipping_message
  };
  
  if ( $new_user == 1 ) {
    $message .= qq{ <br/> При оформлении заказа пользователю  была создана учетная запись. };
    $user_message .= qq{
      <p>При оформлениии заказа для вас была создана учетная запись. Данные для входа в личный кабинет:<br/>
      Логин: $email,<br/>
      Пароль: $password<br/>
      </p>
    };
  }
  
  return ($message,$user_message);

}

sub basketstep2{
    my $tv=$::params->{TMPL_VARS}; my $dbh=$::params->{dbh};
    my $pay = param('pay');
    
    $tv->{form_vls2}->{pay} = $pay;
    my $usl_dost = $tv->{form_vls2}{usl_dost}    = param('usl_dost');
    my $city     = $tv->{form_vls2}{city}        = param('city');
    my $street   = $tv->{form_vls2}{ship_street} = param('ship_street'); 
    my $house    = $tv->{form_vls2}{ship_house}  = param('ship_house');
    my $korp     = $tv->{form_vls2}{ship_korp}   = param('ship_korp');
    my $flat= $tv->{form_vls2}{ship_flat}   = param('ship_flat');

    my $form_status;
    if ( !$pay ) {
       $tv->{errors}{pay} = 'Не выбран способ оплаты';
       $form_status = 'error';
    }
    if ( !$usl_dost ) {
       $tv->{errors}{usl_dost} = 'Не выбраны условия доставки';
       $form_status = 'error';              
    }
     
    if ( $usl_dost == 2 ) {
        if ( !$city ) {
            $tv->{errors}{city} = 'Поле Город не заполнено';
            $form_status = 'error';
        }
        else {
            my $s = &::GET_DATA({
                struct=>'cities',
                where=>'rubricator_id=?',
                onerow=>1, },
                $city
            );

            my $const = $tv->{const}{pricedostavkamin}; my $del;
         
            if ( $tv->{total_sum} > $const ) {
                $del = $s->{shipping_max};
                $tv->{TOTAL_SUM_WITH_DELIVERY} = int($tv->{total_sum})+int($del);
            }
            else {
                $del = $s->{shipping_min};
                $tv->{TOTAL_SUM_WITH_DELIVERY} = int($tv->{total_sum})+int($del);
            }
        }
        if ( !$street || !$house || !$flat ) {
            $tv->{errors}{house} = !$house ? 'Поле Дом не заполнено' : undef;
            $tv->{errors}{street} = !$street ? 'Поле Улица не заполнено' : undef;
            $tv->{errors}{flat} = !$flat ? 'Поле Квартира/Офис не заполнено' : undef ;
            $form_status = 'error';
        }
    }
    $tv->{form_status} = $form_status;
}

return 1;