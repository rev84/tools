// Generated by CoffeeScript 1.12.7
String.prototype.anagrammatize = function() {
  var ary;
  ary = this.split('');
  ary = ary.shuffle();
  return ary.join('');
};

$().ready(function() {
  $('#anagrammatize').on('click', function() {
    return $('#after').val($('#before').val().anagrammatize());
  });
  return $('#before, #after').on('click', function() {
    return $(this).select();
  });
});
