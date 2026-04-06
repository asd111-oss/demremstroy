var APIkey = ''; // Removed for security
var APIurl = 'https://translate.yandex.net/api/v1.5/tr.json/translate';

function trans (text,lang){
  $.ajax({
    url: APIurl,
    data: { key: APIkey, lang:'ru-'+lang, text: text },
    success: function (d,e) { console.log(d.text[0]); }
  });
}

function to_lang (langs, text, id, type, id2){
  var lang_arr = langs.split(',');
  $.each(lang_arr, function (ind,val) {
    $.ajax({
      url: APIurl,
      data: { key: APIkey, lang:'ru-'+val, text: text },
      dataType: 'json',
      success: function (d,e) {
        if ( type == 1 ){
          if ( id2 ) {
            tinyMCE.get(id2+'_'+val).setContent(d.text[0]);
          }
          else {
            tinyMCE.get(id+'_'+val).setContent(d.text[0]);
          }
        }
        else {
          if ( id2 ) {
            $('#'+id2+'_'+val).val(d.text[0]);
          }
          else {
            $('#'+id+'_'+val).val(d.text[0]);
          }
        }
      }
    });
  });
}

function trans_to(id,lang,type) {
  var text = $('#'+id).val();
  $.ajax({
    url: 'https://translate.yandex.net/api/v1.5/tr.json/translate',
    data: { 
      key: APIkey,
      lang: 'ru-'+lang,
      text: text,
    },
    dataType: 'json',
    success: function(d,e){
      if ( type == 1 ){
        $('#'+id+'_'+lang).val(d.text);
      }
      else {
        return d.text;
      }
    }
  });
}

function trans_fields(fields,langs) {
  var fld = fields.split(',');
  var lng = langs ? langs : 'en';
  $.each(fld, function(ind,val){
    var t = val.split(':');
    if ( t[0] == 'w' ){
      var text = tinyMCE.get(t[1]).getContent();
      to_lang(lng,text,t[1],1);
    }
    else{
      var text = $('#'+t[1]).val();
      to_lang(lng,text,t[1]);
    }
  });
}
