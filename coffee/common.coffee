window.TOOLS = [
  'json_viewer'
  'case_converter'
  'password_generator'
  'qrcode'
  'anagram'
  'template_replacer'
  'roulette'
  'random_picker'
  'telopper'
  'time_converter'
]

$().ready ->
  htmls = []
  for toolName in window.TOOLS
    htmls.push '<a href="./'+toolName+'.html"><img width="32" height="32" src="favicon/'+toolName+'.ico"></a>'
  htmls.push '<a href="https://github.com/rev84/tools" target="_blank">GitHub</a>'
  $('#menu').html(htmls.join(' / '))

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