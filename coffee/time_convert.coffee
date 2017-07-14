$().ready ->
  $('#to_right').on 'click', s2d
  $('#to_left').on 'click', d2s


s2d = ->
  ms = $('#milisecond').val()
  s = $('#second').val()
  $('#left_timezone').val().match(/^(+-)\d{2}:\d{2}$/)

  ms = if ms is '' then s else ms

  d = new Date()
  d.setTime ms

