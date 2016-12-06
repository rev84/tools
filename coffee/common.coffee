$().ready ->
  $('#menu').html(
    '<a href="./json_viewer.html"><img width="32" height="32" src="favicon/json_viewer.ico"></a>'+' / '+
    '<a href="./case_converter.html"><img width="32" height="32" src="favicon/case_converter.ico"></a>'+' / '+
    '<a href="./password_generator.html"><img width="32" height="32" src="favicon/password_generator.ico"></a>'+' / '+
    '<a href="./qrcode.html"><img width="32" height="32" src="favicon/qrcode.ico"></a>'+' / '+
    '<a href="./anagram.html"><img width="32" height="32" src="favicon/anagram.ico"></a>'+' / '+
    '<a href="./random_picker.html"><img width="32" height="32" src="favicon/random_picker.ico"></a>'+' / '+
    '<a href="./telopper.html"><img width="32" height="32" src="favicon/telopper.ico"></a>'+' / '+
    '<a href="https://github.com/rev84/tools" target="_blank">GitHub</a>'
  )

mt_rand = (min, max)->
  Math.round()
  Math.floor(Math.random() * (max - min + 1)) + min

Array::shuffle = ()->
  n = @length
  while n
    n--
    i = mt_rand(0, n)
    [@[i], @[n]] = [@[n], @[i]]
  @

Array::in_array = (value)->
  for v in @
    return true if v is value
  false

Array::copy = ()->
  res = []
  for v in @
    res2 = []
    for v2 in v
      res2.push v2
    res.push res2
  res