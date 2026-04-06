var ecom = {
  cid: 0,
  cnt: 1,
  gid: 0,
  send: function ( data ){
    $.ajax({
      url: '/ecom.pl',
      data: data,
      async: false,
      success: function (d) {
        window.dataLayer.push(d);
        console.log( data.act + ': ' + window.dataLayer );
      }
    });
  },
  view: function ( gid, cid ){
    this.gid = gid;
    this.cid = cid;
    this.send({ act: 'view', gid: gid, cid: cid });
  },
  del: function ( gid, cid ){
    this.gid = gid;
    this.cid = cid;
    this.send({ act: 'del', gid: gid, cid: cid });
  },
  add: function ( gid, cid, cnt ){
    this.gid = gid;
    this.cid = cid;
    this.send({act: 'add', gid: gid, cid: cid, cnt: cnt });
  },
  order: function ( good_list, cid, oid ){
    this.send({ act: 'order', cid: cid, good_list: good_list, oid: oid });
  }
};
