window.dataLayer = window.dataLayer || [];
basket = {
  cid: 0,
  name: 'basket',
  ecom: function ( data ){
    if (this.cid == 0) {
      console.log('Ecom_log: CID not defined');
      return false;
    }
    data.cid = this.cid;
    $.ajax({
      url: '/ecom.pl',
      data: data,
      async: false,
      success: function (d) {
        window.dataLayer.push(d);
        if ( this.debug == 1 ){
          console.log('Ecom_log:' + d);
        }
      }
    });
  },
  send: function ( data, upd ) {
    if ( !upd ) { upd = '#basket_info'; }
    data.basket = this.name;
    $.ajax({
      url: '/basket_info',
      data: data,
      success: function (d) {
        $(upd).html(d);
      }
    });
  },
  add: function (rec_id,cnt) {
    if ( !cnt ) { cnt=1; }
    if ( !rec_id ) {
       alert('not rec_id')
       return false
    }	
    this.send({ action: 'add', rec: rec_id, cnt: cnt });
    this.ecom({ act: 'add', gid: rec_id, cnt: cnt });
  },
  view: function ( gid ) { this.ecom({ act: 'view', gid: gid }); },
  update: function () {
    var formlist = $('#basket_update input');
    var reg = /^rec_id_(\d+)$/;
    str = '';
    for ( i = 0; i < formlist.length; i++ ) {
      if ( formlist[i].name ) {
        var arr = reg.exec(formlist[i].name);
        if ( arr ){
          str += '&rec_id=' + arr[1] + '&cnt=' + formlist[i].value;
        }
      }
    }
    this.send('action=update'+str,'#basket_update');
  },
  del: function (rec_id,cnt,basket_name) {
    if ( !rec_id ) { alert('not rec_id'); return false; }
    if ( !cnt ) { cnt = 0; }
    if ( !basket_name ) { this.name = 'basket'; }
    this.send({ action: 'del', rec: rec_id, cnt: cnt });
    this.ecom({ act: 'del', gid: rec_id });
  },
  clean: function() {
    this.send({action:'clean'});
  },
  order: function ( good_list, oid ){
    this.ecom({ act: 'order', good_list: good_list, oid: oid });
  }
}

function delrow(num_id){
   var tbody = document.getElementById('bsk'+num_id).parentNode;
   tbody.removeChild(document.getElementById('bsk'+num_id));
}
