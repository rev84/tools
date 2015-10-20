String::camelize =->
  @replace /(^|\-|\_)(\w)/g, (a,b,c)->
    c.toUpperCase()
String::snakize =->
  res = @replace /[A-Z]/g, (s)->
    "_" + s.charAt(0).toLowerCase()
  res.substring (if res.substring(0, 1) is '_' then 1 else 0)

$().ready ->
  $('#camelize').on 'click', ->
    $('#after').val $('#before').val().camelize()
  $('#snakize').on 'click', ->
    $('#after').val $('#before').val().snakize()
  $('#before, #after').on 'click', ->
    $(this).select()