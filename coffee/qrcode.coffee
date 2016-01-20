$().ready ->
  $('#convert').on 'click', ->
    $('#qrcode').html('')
    $('#qrcode').qrcode(
      size  : 200
      color : '#000000'
      text  : $('#url').val()
    )