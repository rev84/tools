window.CONST = 
  TIME_CONVERTER_LEFT_TIMEZONE : 'TIME_CONVERTER_LEFT_TIMEZONE'
  TIME_CONVERTER_RIGHT_TIMEZONE : 'TIME_CONVERTER_RIGHT_TIMEZONE'

$().ready ->
  $('#to_right').on 'click', s2d
  $('#to_left').on 'click', d2s

  v = Utl.getLs window.CONST.TIME_CONVERTER_LEFT_TIMEZONE
  $('#left_timezone').val(v) if v isnt null
  v = Utl.getLs window.CONST.TIME_CONVERTER_RIGHT_TIMEZONE
  $('#right_timezone').val(v) if v isnt null

  $('#left_timezone').on 'change', ->
    v = Utl.setLs window.CONST.TIME_CONVERTER_LEFT_TIMEZONE, $('#left_timezone').val()
  $('#right_timezone').on 'change', ->
    v = Utl.setLs window.CONST.TIME_CONVERTER_RIGHT_TIMEZONE, $('#right_timezone').val()

s2d = ->
  ms = $('#milisecond').val()
  s = $('#second').val()
  # 標準時に戻す
  [_, hugou, leftH, leftM] = $('#left_timezone').val().match(/^([+-])(\d{2})\.(\d{2})$/)
  plusMin = Number(leftH) * 60 + Number(leftM)
  plusMin *= -1 if plusMin is '-'
  ms = if ms is '' then s*1000 else ms
  ms -= plusMin * 60 * 1000

  # ローカル時に変換する
  [_, hugou, rightH, rightM] = $('#right_timezone').val().match(/^([+-])(\d{2})\.(\d{2})$/)
  plusMin = Number(rightH) * 60 + Number(rightM)
  plusMin *= -1 if plusMin is '-'
  ms += plusMin * 60 * 1000

  dt = new Date()
  dt.setTime ms
  $('#date').val date2string dt

d2s = ->
  date = $('#date').val().match(/^(\d{4})-(\d{2})-(\d{2}) (\d{2}):(\d{2}):(\d{2})$/)
  return window.alert '^(\d{4})-(\d{2})-(\d{2}) (\d{2}):(\d{2}):(\d{2})$ のみ対応' unless date

  [_, y, m, d, h, i, s] = date
  dt = new Date()
  dt.setUTCFullYear Number y
  dt.setUTCMonth Number(m-1)
  dt.setUTCDate Number d
  dt.setUTCHours Number h
  dt.setUTCMinutes Number i
  dt.setUTCSeconds Number s
  dt.setUTCMilliseconds 0

  # 標準時に戻す
  ms = dt.getTime()
  [_, hugou, rightH, rightM] = $('#right_timezone').val().match(/^([+-])(\d{2})\.(\d{2})$/)
  plusMin = Number(rightH) * 60 + Number(rightM)
  plusMin *= -1 if plusMin is '-'
  ms -= plusMin * 60 * 1000

  # ローカル時に変換する
  [_, hugou, leftH, leftM] = $('#left_timezone').val().match(/^([+-])(\d{2})\.(\d{2})$/)
  plusMin = Number(leftH) * 60 + Number(leftM)
  plusMin *= -1 if plusMin is '-'
  ms += plusMin * 60 * 1000

  $('#milisecond').val(ms)
  $('#second').val(Math.floor(ms/1000))

date2string = (date)->
  y = date.getUTCFullYear()
  m = date.getUTCMonth()+1
  d = date.getUTCDate()
  h = date.getUTCHours()
  i = date.getUTCMinutes()
  s = date.getUTCSeconds()

  fillZero(y, 4)+'-'+fillZero(m)+'-'+fillZero(d)+' '+fillZero(h)+':'+fillZero(i)+':'+fillZero(s)

fillZero = (v, digit = 2)->
  ('000'+v).substr -digit, digit

