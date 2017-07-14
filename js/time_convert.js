// Generated by CoffeeScript 1.12.6
var s2d;

$().ready(function() {
  $('#to_right').on('click', s2d);
  return $('#to_left').on('click', d2s);
});

s2d = function() {
  var d, ms, s;
  ms = $('#milisecond').val();
  s = $('#second').val();
  $('#left_timezone').val().match(/^(+-)\d{2}:\d{2}$/);
  ms = ms === '' ? s : ms;
  d = new Date();
  return d.setTime(ms);
};
