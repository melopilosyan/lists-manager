(function () {
  window.cookies = {
    set: function (name, value, options) {
      var d = new Date(), o = options || {}, days = o.days || 365, path = o.path ? '' : '; path=' + o.path;
      d.setTime(d.getTime() + (days*24*60*60*1000));
      document.cookie = name + '=' + value + '; expires=' + d.toUTCString() + path;
    },
    get: function (name) {
      var cn = name + '=', cs = document.cookie.split('; '), i = cs.length, c;
      for(; i-- ;) {
        c = cs[i];
        if (c.indexOf(cn) == 0) return c.substring(cn.length, c.length);
      }
      return null;
    }
  }
}());

