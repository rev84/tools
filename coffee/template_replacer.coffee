MAX_LOOP_COUNT = 1000 * 1000
window.GLOBAL = 
  CLIPBOARD : null

$().ready ->
  $('#replace').on 'click', replace
  $('#copy').on 'click', clipboradCopy
  $('#calcable').on 'change', calcableConfig

calcableConfig = ->
  if $('#calcable').prop('checked')
    $('.calcable_config').removeClass('no_display')
  else
    $('.calcable_config').addClass('no_display')

replace = ->
  needle = $('#needle').val()
  start = Number $('#start').val()
  end = Number $('#end').val()
  pace = Number $('#pace').val()
  template = $('#template').val()
  calcable = $('#calcable').prop('checked')
  kakko_start = $('#kakko_start').val()
  kakko_end = $('#kakko_end').val()

  return alert('開始番号が異常です') if isNaN(start)
  return alert('終了番号が異常です') if isNaN(end)
  return alert('番号の増加量が異常です') if isNaN(pace) || pace is 0
  return alert('開始番号＞終了番号になっています') if start > end

  loop_count = Math.abs((end - start) / pace)
  return alert(''+MAX_LOOP_COUNT.toLocaleString()+'回を超えるループになっています') if isNaN(loop_count) or loop_count > MAX_LOOP_COUNT

  res = ''
  count = start
  while true
    if calcable
      reg = new RegExp(''+kakko_start+'([^'+kakko_end+']*)'+kakko_end, 'g')
      replaceString = (str, p)->
        eval(p.replaceAll(needle, count))
      res += template.replaceAll(reg, replaceString)
    else
      res += template.replaceAll(needle, count.toString())

    count += pace
    break if (pace < 0 and count < end) or (pace > 0 and count > end)

  $('#result').html(res)

clipboradCopy = ->
  navigator.clipboard.writeText $('#result').html()