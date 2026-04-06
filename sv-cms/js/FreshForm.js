
$(document).ready(

  function(){
   
    $.each($('.FreshForm'),
      function(i,Fresh){
        
        $(Fresh).submit(

          function(){
            
            var form=$(Fresh);
            if( $(form).hasClass("js-validate") && $(form).data("jvalidate").errors ){
            	return;
            }
            var action=$(Fresh).attr('action');
            var show_id=$(Fresh).data('show-id');
            var hide_id=$(Fresh).data('hide-id');
            var before_send=$(Fresh).data('before_send');
            var after_send=$(Fresh).data('after_send');
            var vice_send=$(Fresh).data('vice_send');

            var tradition_send=$(Fresh).data('tradition_send');
            var arr=$(Fresh).find('input[type=text],input[type=tel],input[type=email],textarea');
            var r=1;
            for (var i=0; i<arr.length; i++){
              var el=arr[i];
              r*=check_element(el);
              
            }

            if(!r) return false;
            
            if(vice_send){
              eval(vice_send);
              
              return false;
            }
            
            if(before_send){
              eval(before_send)
            }
            if(!show_id && !after_send && !tradition_send && !vice_send){
              alert('not set form > show_id');
            }
            if(!tradition_send && !after_send && !$(Fresh).attr('action') && !vice_send){
              alert('not set form > action');
              return false;
            }

            var serial=$(form).serialize();
            if(!(serial.match(/(&|^)action=/))){
              serial+='&action=form_send'
            }
            serial+='&bo'+
              't=fuc'+
              'kb'+
                'ot';


            if(tradition_send)
              return true;

            if(!action){
              if(after_send) eval(after_send);
            }
            else
            {

            
            
              $.post(action,serial).done(
                function(data){
                  if(data=='1'){                  
                    if(show_id){
                      $('#'+show_id).show();
                      document.location.href='#'+show_id;
                    }
                    if(hide_id)
                      $('#'+hide_id).hide();
                    /*console.log(after_send);*/
                    if(after_send) eval(after_send);
                    
                    
                  }
                  else{
                    var arr=data.split(',');
                    $(form).find('.error').removeClass('error');
                    for(i=0;i<arr.length;i++){
                      var el=$('form').find('input[name='+arr[i]+'], textarea[name='+arr[i]+'], select[name='+arr[i]+']');
                      if($(el).data('error_element_id')){
                        el=$('#'+$(el).data('error_element_id'));
                      }else if($(form).hasClass('js-validate')){
                      	$(el).data("jvalidate",{"form":form});
                      	$(el).jvalidate('addErrorMessageCorrect');
                      }

                      $(el).addClass('error');
                    }
                  }
                  
                  }
              );
            }
            return false;
          }
        )
      
      }
    );
    
    $('input, textarea, select').each(
      function(i,el){
        
        $(el).keyup(
          function(){
            replace_element(el);
            check_element(el);
          }
        );
        $(el).change(
          function(){
            check_element(el);
          }
        );
      }
    );
  }

);

function replace_element(el){
  
  if(!$(el).attr('data-replfrom'))
    return;
  var v=$(el).val(); var old=$(el).attr('old');
  if((v==old) || !v)
    return ;
    
  var replfrom=$.parseJSON($(el).attr('data-replfrom'));
  var replto=$.parseJSON($(el).attr('data-replto'));
  if(replfrom.length>0){
    for(i=0;i<replfrom.length;i++){
      re=new RegExp(replfrom[i],'g');
      var pos=$(el).getCursorPosition();
      v=v.replace(re,replto[i]);
      $(el).val(v);
      $(el).setCursorPosition(pos);
      $(el).attr('old',v);
    }
  }
}
function check_element(el,regexp){  
  var regexp=$(el).attr('data-regexp');
  if(regexp){
    var v=$(el).val();
    var re=new RegExp(regexp);
    if($(el).data('error_element_id')){
      el=$('#'+$(el).data('error_element_id'));      
    };
    if(re.test(v)){
      $(el).removeClass('error');
      $('#submit_button').prop('disabled',false);
      return 1;
    }
    else{
      $(el).addClass('error');
      $('#submit_button').prop('disabled',true);
      return 0;
    }
    
  }
  return 1;
}

$.fn.setCursorPosition = function(pos) {
    this.each(function(index, elem) {
    if (elem.setSelectionRange) {
        elem.setSelectionRange(pos, pos);
    } else if (elem.createTextRange) {
        var range = elem.createTextRange();
        range.collapse(true);
        range.moveEnd('character', pos);
        range.moveStart('character', pos);
        range.select();
    }
    });
    return this;
};

jQuery.fn.getCursorPosition = function(){
  if(this.lengh == 0) return -1;
  return $(this).getSelectionStart();
}

jQuery.fn.getSelectionStart = function(){
  if(this.lengh == 0) return -1;
  input = this[0];
  var pos = input.value.length;
  return pos;
}
