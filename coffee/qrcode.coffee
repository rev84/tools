$().ready ->
  $('input').on 'click', ->
    $(this).select()
  query = window.location.search.substring(1)
  if query is ''
    $('#convert').on 'click', ->
      $('#qrcode').html('').qrcode(
        size  : 250
        color : '#000000'
        text  : $('#url').val()
      )
      $('#qrcode').children('canvas').off('click').on('click', ->
        window.open $('#url').val()
      )
      $('#permalink').val(location.href+'?'+encodeURIComponent($('#url').val()))
  else
    url = decodeURIComponent query
    $('#url').val(url).attr('readonly', true)
    $('#convert').hide()
    $('.perma').hide()
    $('#qrcode').html('').qrcode(
      size  : 250
      color : '#000000'
      text  : url
    ).off('click').on('click', ->
      window.open url
    )
