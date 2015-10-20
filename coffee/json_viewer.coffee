reset = ->
  $('#message').html ''
  $('#compressed').removeClass 'error'
  $('#ordered').removeClass 'error'
  return

$().ready ->
  $('#compressize').on 'click', ->
    reset()
    json = $('#ordered').val()
    try
      jsonArray = JSON.parse(json)
    catch e
      $('#message').html 'JSONが不正です。'
      $('#ordered').addClass 'error'
      return false
    jsonStr = JSON.stringify(jsonArray, null, 0)
    $('#compressed').val jsonStr
    return
  $('#orderize').on 'click', ->
    reset()
    json = $('#compressed').val()
    try
      jsonArray = JSON.parse(json)
    catch e
      $('#message').html 'JSONが不正です。'
      $('#compressed').addClass 'error'
      return false
    jsonStr = JSON.stringify(jsonArray, null, 4)
    $('#ordered').val jsonStr
    return
  $('#selectCompressed').on 'click', ->
    $('#compressed').select()
    return
  $('#selectOrdered').on 'click', ->
    $('#ordered').select()
    return
  return
