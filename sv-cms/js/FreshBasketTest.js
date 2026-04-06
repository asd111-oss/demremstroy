
$(document).ready(function(){
	//checkForm();
	$('.buyBtn').click(function(){basket.add($(this).attr('href'));return false;})
	$('.BasketAddOne').click(function(){basket.add($(this).attr('href'),1);return false;})
	$('.BasketDelOne').click(function(){basket.del($(this).attr('href'),1);return false;})
	$('.delGood').click(function(){basket.del($(this).attr('href'));$(this).parents('.item').remove();return false;})

  $('.BasketCount').change(
    function(){
      cnt=$(this).val();
      rec_id=$(this).data('id');

      cnt=cnt.replace(/\D+/g,"");
      
      if(!cnt)
        cnt=1;

      $(this).val(cnt);
      basket.update(rec_id,cnt);
    }
  );
})

function template_basket_update(data){
	var o=jQuery.parseJSON(data)
	$('#basket_info').html(o.html_data);
  
  //console.log(basket.rec_id);
	//console.log(o);
	if(o.cur_record_count && $('#good_count'+basket.rec_id)[0]){
    console.log('#good_count'+basket.rec_id);
    var tn=$('#good_count'+basket.rec_id)[0].tagName;
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
	}
	if(document.location.pathname=='/basket' && (o.add_new_record) ){ // РµСЃР»Рё РґРѕР±Р°РІР»СЏРµРј РЅРѕРІС‹Р№ С‚РѕРІР°СЂ, РєРѕС‚РѕСЂРѕРіРѕ СЂР°РЅСЊС€Рµ РЅРµ Р±С‹Р»Рѕ -- РѕР±РЅРѕРІР»СЏРµРј РєРѕСЂР·РёРЅСѓ
		document.location.href='/basket'
	}
}

basket={
	name: 'basket'
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
	if(!cnt)
		cnt=1
	if(!rec_id){
	 alert('not rec_id')
	 return false
	}
	var attr_string=get_attr_string(attr);
	
	basket.rec_id=rec_id;
  
	$.ajax({
			url: '/basket_info?action=add&rec='+rec_id+'&cnt='+cnt+'&basket='+basket.name+attr_string,
			success: function(data){
				template_basket_update(data);
        $('#modal_basket').jmodal('show');
        var json=JSON.parse(data);
        $('#bsk'+rec_id+' .cur_record_total_price').html(json.cur_record_total_price);
        $('.total_price').html(json.total_price);
        $('.total_count').html(json.total_count);
			}
	});
   
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
			success: function(data){
        var json=JSON.parse(data);
        $('#bsk'+rec_id+' .cur_record_total_price').html(json.cur_record_total_price);
        $('.total_price').html(json.total_price);
        $('.total_count').html(json.total_count);
				//template_basket_update(data);
				//document.location.href='/basket'
			}
	});
}


basket.del=function(rec_id,cnt,attr){
	if(!rec_id){
	 console.log('not rec_id')
	 return false
	}
	if(!cnt){
		cnt=0;
	}
	
	var attr_string=get_attr_string(attr);

	basket.rec_id = rec_id
	$.ajax({
			url: '/basket_info?action=del&rec='+rec_id+'&cnt='+cnt+'&basket='+basket.name+attr_string,
			success: function(data){
        var json=JSON.parse(data);
        
        
        $('#bsk'+rec_id+' .cur_record_total_price').html(json.cur_record_total_price);
				template_basket_update(data);
        $('.total_price').html(json.total_price);
        $('.total_count').html(json.total_count);
			}
	});
}

basket.clean=function(){
	$.ajax({
			url: '/basket_info?action=clean',
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
