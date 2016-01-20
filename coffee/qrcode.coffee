$().ready ->
  $('#url').on 'click', ->
    $(this).select()
    
  $('#convert').on 'click', ->
    $('#qrcode').html('').qrcode(
      size  : 200
      color : '#000000'
      text  : $('#url').val()
    ).off('click').on('click', ->
      window.open $('#url').val()
    )