$().ready ->
  $('#menu').html(
    '<a href="./json_viewer.html">JSON Viewer</a>'+' / '+
    '<a href="./case_converter.html">Case Converter</a>'+' / '+
    '<a href="./password_generator.html">Password Generator</a>'+' / '+
    '<a href="./qrcode.html">QRCode Converter</a>'
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