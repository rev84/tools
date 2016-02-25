// Generated by CoffeeScript 1.10.0
var mt_rand;

$().ready(function() {
  return $('#menu').html('<a href="./json_viewer.html"><img width="32" height="32" src="favicon/json_viewer.ico"></a>' + ' / ' + '<a href="./case_converter.html"><img width="32" height="32" src="favicon/case_converter.ico"></a>' + ' / ' + '<a href="./password_generator.html"><img width="32" height="32" src="favicon/password_generator.ico"></a>' + ' / ' + '<a href="./qrcode.html"><img width="32" height="32" src="favicon/qrcode.ico"></a>' + ' / ' + '<a href="./anagram.html"><img width="32" height="32" src="favicon/anagram.ico"></a>' + ' / ' + '<a href="https://github.com/rev84/tools" target="_blank">GitHub</a>');
});

mt_rand = function(min, max) {
  Math.round();
  return Math.floor(Math.random() * (max - min + 1)) + min;
};

Array.prototype.shuffle = function() {
  var i, n, ref;
  n = this.length;
  while (n) {
    n--;
    i = mt_rand(0, n);
    ref = [this[n], this[i]], this[i] = ref[0], this[n] = ref[1];
  }
  return this;
};

Array.prototype.in_array = function(value) {
  var j, len, v;
  for (j = 0, len = this.length; j < len; j++) {
    v = this[j];
    if (v === value) {
      return true;
    }
  }
  return false;
};

Array.prototype.copy = function() {
  var j, k, len, len1, res, res2, v, v2;
  res = [];
  for (j = 0, len = this.length; j < len; j++) {
    v = this[j];
    res2 = [];
    for (k = 0, len1 = v.length; k < len1; k++) {
      v2 = v[k];
      res2.push(v2);
    }
    res.push(res2);
  }
  return res;
};
