
$(document).ready(function(){
    //checkForm();
    $('.buyBtn').click(function(){
        let cnt=$('.addBasketCnt').val();
        if(!cnt)
            cnt=1;
        
        basket.add($(this).attr('href'),cnt);
        return false;
    })
    $('.BasketAddOne').click(function(){
      var id=$(this).attr('href');
      //console.log($('.BasketCount["data-id='+id+']'));
      //var cnt=$('#good_count'+id).val();
      //$('#good_count'+id).val(cnt+1);
      basket.add(id,1);return false;
  })
    $('.BasketDelOne').click(function(){basket.del($(this).attr('href'),1);return false;})
    $('.delGood').click(function(){basket.del($(this).attr('href'));$(this).parents('.item').remove();return false;})

 /* $('.BasketCount').change(
    function(){
      cnt=$(this).val();
      rec_id=$(this).data('id');

      cnt=cnt.replace(/\D+/g,"");
      
      if(!cnt)
        cnt=1;
      $(this).val(cnt);
      basket.update(rec_id,cnt);
    }
  );*/
  var lock=0;
  $('.BasketCount').keyup(
    function(){
        var $item=$(this);
        lock++;
        // console.log(item);
        setTimeout(function(){
            lock--;
            if(lock==0){
                let cnt=$item.val();
                let rec_id=$item.attr('id').replace(/rec\_id\_/,"");
                let attr=$item.data('attr');
                rec_id=rec_id.replace(/good\_count/,"");
                cnt=cnt.replace(/\D+/g,"");
                //console.log(cnt);
                if(!cnt)
                    cnt=1;
                $item.val(cnt);
                console.log('cnt'+cnt);
                console.log('rec_id'+rec_id);
                console.log(attr);
                basket.update(rec_id,cnt,attr);
            }
        },300)
    }
  );  
  
})


function recalculate(){
}

function template_basket_update(data){
  //console.log(data);
  var o=jQuery.parseJSON(data);
  
    $('#basket_info').html(o.html_data);
  
    //console.log(basket.rec_id);

    if(o.cur_record_count && $('#good_count'+o.cur_record_bl_id)[0]){
        //console.log('#good_count'+basket.rec_id);
        var tn=$('#good_count'+o.cur_record_bl_id)[0].tagName;
        if(tn=='INPUT' || tn=='TEXTAREA')
          $('#good_count'+o.cur_record_bl_id).val(o.cur_record_count);
        else
          $('#good_count'+o.cur_record_bl_id).html(o.cur_record_count);
    }
    if(o.cur_record_total_price){
        $('#good_summ'+o.cur_record_bl_id).text(o.cur_record_total_price);
    }
    if(o.total_price){
        $('#total_price').html(o.total_price);
        $('.total_price').html(o.total_price);
    }
    if(o.total_count){
        $('.total_count').html(o.total_count);
    }
    if(document.location.pathname=='/basket' && (o.add_new_record) ){ 
        document.location.href='/basket'
    }
}

basket={
    name: 'basket',
    show_modal: true
};

function get_attr_string(attr){
    var attr_string='';
    for  (i in attr){
        var key=i;
        var val=attr[i];
        attr_string=attr_string + '&attr_'+key+'='+val
    }
    return attr_string;
}

basket.add = function(rec_id,cnt,attr){
    let loopback;
    if(typeof(rec_id)=='object'){

        let obj=rec_id;
        console.log({obj: obj});
        cnt=obj.cnt,
        loopback=obj.loopback,
        attr=obj.attr
        rec_id=obj.rec_id
    }


    if(!cnt)
        cnt=1
    if(!rec_id){
     alert('not rec_id')
     return false
    }
    var attr_string=get_attr_string(attr);
    
    basket.rec_id=rec_id;
    //console.log('/basket_info?action=add&rec='+rec_id+'&cnt='+cnt+'&basket='+basket.name+attr_string);
    $.ajax({
        url: '/basket_info?action=add&rec='+rec_id+'&cnt='+cnt+'&basket='+basket.name+attr_string,
        method: 'post',
        success: function(data){
            template_basket_update(data);
            if(basket.show_modal){
                $('#modal_basket').jmodal('show');
            }
            var json=JSON.parse(data);
            if(json.cur_basket_positions){
                $.each(json.cur_basket_positions, function(){
                    console.log(this);
                    $('#bsk'+this.basket_list_id+' .cur_record_price').html(this.bl_price);
                    $('#bsk'+this.basket_list_id+' .cur_record_total_price').html(this.bl_price*this.count);
                });
            }else{
                $('#bsk'+json.cur_record_bl_id+' .cur_record_total_price').html(json.cur_record_total_price);
            }
            if(json.add_return_fields){
                $.each(json.add_return_fields,function(index,value){
                    $('.'+index).html(value);
                });
            }
            
            $('.total_price').html(json.total_price);
            $('.total_count').html(json.total_count);
            json['action']='add';
            if(json.after_js_code){
                eval(json.after_js_code);
            }
            if(loopback)
                loopback(json)
        }
    });
   
}

basket.update = function(rec_id,cnt,attr){
    let loopback;
    if(typeof(rec_id)=='object'){
        let obj=rec_id;
        cnt=obj.cnt,
        loopback=obj.loopback,
        attr=obj.attr
        rec_id=obj.rec_id
    }
    if(!cnt)
        cnt=0;
    
    if(!rec_id){
        alert('not rec_id')
        return false;
    }  
  
  let attr_string=get_attr_string(attr);
    $.ajax({
            url: '/basket_info?action=basket_update&rec='+rec_id+'&cnt='+cnt+'&basket='+basket.name+'&'+attr_string,
            method: 'post',
            success: function(data){
                template_basket_update(data);
                let json=JSON.parse(data);
                if(json.cur_basket_positions){
                    $.each(json.cur_basket_positions, function(){
                        console.log(this);
                        $('#bsk'+this.basket_list_id+' .cur_record_price').html(this.bl_price);
                        $('#bsk'+this.basket_list_id+' .cur_record_total_price').html(this.bl_price*this.count);
                    });
                }else{
                    $('#bsk'+json.cur_record_bl_id+' .cur_record_total_price').html(json.cur_record_total_price);
                }
                if(json.add_return_fields){
                    $.each(json.add_return_fields,function(index,value){
                        $('.'+index).html(value);
                    });
                }
                $('.total_price').html(json.total_price);
                $('.total_count').html(json.total_count);
                json.action='update';
                if(json.after_js_code){
                    eval(json.after_js_code);
                }
                if(loopback)
                    loopback(json)
                //template_basket_update(data);
                //document.location.href='/basket'
            }
    });
}


basket.del=function(rec_id,cnt,attr){
    let loopback;
    if(typeof(rec_id)=='object'){
        let obj=rec_id;
        cnt=obj.cnt,
        loopback=obj.loopback,
        attr=obj.attr
        rec_id=obj.rec_id
    }
    if(!rec_id) return false


    
    var attr_string=get_attr_string(attr);

    var Url=cnt?
        '/basket_info?action=del&rec='+rec_id+'&cnt='+cnt+'&basket='+basket.name+attr_string
        :'/basket_info?action=dellall&rec='+rec_id+'&basket='+basket.name+attr_string;

    basket.rec_id = rec_id
    $.ajax({
            url: Url,
                method: 'post',
                success: function(data){
                    let json=JSON.parse(data);
                    if(json.cur_basket_positions){
                        $.each(json.cur_basket_positions, function(){
                            console.log(this);
                            $('#bsk'+this.basket_list_id+' .cur_record_price').html(this.bl_price);
                            $('#bsk'+this.basket_list_id+' .cur_record_total_price').html(this.bl_price*this.count);
                        });
                    }else{
                        $('#bsk'+json.cur_record_bl_id+' .cur_record_total_price').html(json.cur_record_total_price);
                    }
                    if(json.add_return_fields){
                        $.each(json.add_return_fields,function(index,value){
                            $('.'+index).html(value);
                        });
                    }
                    template_basket_update(data);
                    $('.total_price').html(json.total_price);
                    $('.total_count').html(json.total_count);
                    
                    if(!json.total_count)
                        location.href=location.href;
                    json.action='update'
                    if(json.after_js_code){
                        eval(json.after_js_code);
                    }
                    if(loopback)
                        loopback(json)
                }
    });
}

basket.clean=function(){
    $.ajax({
            url: '/basket_info?action=clean',
                method: 'post',
            success: function(data){
                template_basket_update(data);
                var json=JSON.parse(data);
                $('.total_price').html(json.total_price);
                $('.total_count').html(json.total_count);
            }
    });
}

function delrow(num_id){
   var tbody = document.getElementById('bsk'+num_id).parentNode;
   tbody.removeChild(document.getElementById('bsk'+num_id));
}


basket.count_up = function(rec_id,cnt,attr){
    cnt=cnt||1;
    if(!rec_id){
     alert('not rec_id')
     return false
    }
    var attr_string=get_attr_string(attr);    
    basket.rec_id=rec_id;
    $.ajax({
        url: '/basket_info?action=add&rec='+rec_id+'&cnt='+cnt+'&basket='+basket.name+attr_string,
        method: 'post',
        success: function(data){
            template_basket_update(data); 
        }
    });
    return false;
}

basket.count_down = function(rec_id,cnt,attr){
    cnt=cnt||1;
    if(!rec_id){
     alert('not rec_id')
     return false
    }    
    var attr_string=get_attr_string(attr);
    var Url=cnt?
        '/basket_info?action=del&rec='+rec_id+'&cnt='+cnt+'&basket='+basket.name+attr_string
        :'/basket_info?action=dellall&rec='+rec_id+'&basket='+basket.name+attr_string;

    basket.rec_id = rec_id
    $.ajax({
        url: Url,
            method: 'post',
        success: function(data){
            template_basket_update(data);
        }
    });
    return false;
}

