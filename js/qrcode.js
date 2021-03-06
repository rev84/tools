// Generated by CoffeeScript 1.12.7
$().ready(function() {
  var query, url;
  $('input').on('click', function() {
    return $(this).select();
  });
  query = window.location.search.substring(1);
  if (query === '') {
    return $('#convert').on('click', function() {
      $('#qrcode').html('').qrcode({
        size: 250,
        color: '#000000',
        text: $('#url').val()
      });
      $('#qrcode').children('canvas').off('click').on('click', function() {
        return window.open($('#url').val());
      });
      return $('#permalink').val(location.href + '?' + encodeURIComponent($('#url').val()));
    });
  } else {
    url = decodeURIComponent(query);
    $('#url').val(url).attr('readonly', true);
    $('#convert').hide();
    $('.perma').hide();
    return $('#qrcode').html('').qrcode({
      size: 250,
      color: '#000000',
      text: url
    }).off('click').on('click', function() {
      return window.open(url);
    });
  }
});
