
$(document).ready(function(){
    $('.buyBtn').click(function(){
        let cnt=$('.addBasketCnt').val();
        if(!cnt)
            cnt=1;
        
        basket.add($(this).attr('href'),cnt);
        return false;
    })
    $('.BasketAddOne').click(function(){
      let id=$(this).attr('href');
      basket.add(id,1);return false;
  })
    $('.BasketDelOne').click(function(){basket.del($(this).attr('href'),1);return false;})
    $('.delGood').click(function(){basket.del($(this).attr('href'));$(this).parents('.item').remove();return false;})


  var lock=0;
  $('.BasketCount').keyup(
    function(){
          lock++;
        setTimeout(function(){
            lock--;
            if(lock==0){
                let cnt=$('.BasketCount').val();
        
                let rec_id=$('.BasketCount').attr('id').replace(/rec\_id\_/,"");
                rec_id=rec_id.replace(/good\_count/,"");
                cnt=cnt.replace(/\D+/g,"");
                if(!cnt)
                    cnt=1;
                $('.BasketCount').val(cnt);
                basket.update(rec_id,cnt);
            }
        },300)
    }
  );  
  
})


function recalculate(){
}

function template_basket_update(data){
  //console.log(data);
  let o=data;
  
    $('#basket_info').html(o.html_data);
    if(o.cur_record_count && $('#good_count'+basket.rec_id)[0]){
        let tn=$('#good_count'+basket.rec_id)[0].tagName;
        if(tn=='INPUT' || tn=='TEXTAREA')
          $('#good_count'+basket.rec_id).val(o.cur_record_count);
        else
          $('#good_count'+basket.rec_id).html(o.cur_record_count);
    }
    if(o.cur_record_total_price){
        $('#good_summ'+basket.rec_id).text(o.cur_record_total_price);
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
        let key=i;
        let val=attr[i];
        attr_string=attr_string + '&attr_'+key+'='+val
    }
    return attr_string;
}

basket.add = function(rec_id,cnt,attr){
    if(!cnt)
        cnt=1
    if(!rec_id){
     alert('not rec_id')
     return false
    }
    var attr_string=get_attr_string(attr);
    
    basket.rec_id=rec_id;
    axios.post(
        '/basket_info?action=add&rec='+rec_id+'&cnt='+cnt+'&basket='+basket.name+attr_string,
    ).then(
        (r)=>{
            let data=r.data; // уже объект javascript
            let data_text=r.request.responseText; // текст ответа
            template_basket_update(data);

            if(basket.show_modal){
                $('#modal_basket').jmodal('show');
            }
            let json=JSON.parse(data_text); //делаем JSON.parse на текстовую строку ответа
            //console.log(json);
            $('#bsk'+rec_id+' .cur_record_total_price').html(json.cur_record_total_price);
            $('.total_price').html(json.total_price);
            $('.total_count').html(json.total_count);
        }
    )
   
}

basket.update = function(rec_id,cnt,attr){
    if(!cnt)
        cnt=0;
    
    if(!rec_id){
        alert('not rec_id')
        return false;
    }  
  
    var attr_string=get_attr_string(attr);
    $.ajax({
            url: '/basket_info?action=basket_update&rec='+rec_id+'&cnt='+cnt+'&basket='+basket.name+'&'+attr_string,
            method: 'post',
            success: function(data){
                template_basket_update(data);
                let json=JSON.parse(data);
                $('#bsk'+rec_id+' .cur_record_total_price').html(json.cur_record_total_price);
                $('.total_price').html(json.total_price);
                $('.total_count').html(json.total_count);
            }
    });
}


basket.del=function(rec_id,cnt,attr){
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
                $('#bsk'+rec_id+' .cur_record_total_price').html(json.cur_record_total_price);
                template_basket_update(data);
                $('.total_price').html(json.total_price);
                $('.total_count').html(json.total_count);
                if(!json.total_count)
                    location.href=location.href;
            }
    });
}

basket.clean=function(){
    $.ajax({
        url: '/basket_info?action=clean',
        method: 'post',
        success: function(data){
            console.log(data);
            template_basket_update(data);
            let json=JSON.parse(data);
            $('.total_price').html(json.total_price);
            $('.total_count').html(json.total_count);
        }
    });
}

function delrow(num_id){
   let tbody = document.getElementById('bsk'+num_id).parentNode;
   tbody.removeChild(document.getElementById('bsk'+num_id));
}


basket.count_up = function(rec_id,cnt,attr){
    cnt=cnt||1;
    if(!rec_id){
     alert('not rec_id')
     return false
    }
    let attr_string=get_attr_string(attr);    
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
    let attr_string=get_attr_string(attr);
    let Url=cnt?
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

