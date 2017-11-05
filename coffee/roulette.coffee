window.CONST =
  FONT_SIZE: 50
  SPEED_RAD: (Math.PI * 2) / 3  # 1秒あたりの角度
  SPEED_RAD_ENDING: (Math.PI * 2) / 30  # 最後の粘りの1秒あたりの速度
  ROLL_DIRECTION_IS_CLOCK: false  # 回転方向は時計回りか
  FPS: 60 # 1秒あたりの描画

window.alternatives = []
window.timer = false
window.rotate = 0
window.speed = false
window.speedDecrease = false
window.endingLimit = false

$().ready ->
  $('#arrow').css({
    left: 0
    top: ($('#roulette_window').height() - $('#arrow').height())/2
  })
  autosize($('#alternatives'))
  $('#alternatives').on 'change keyup', generateRoulette
  generateRoulette()
  doButtonStart()

doButtonStart = ->
  $('#btn').off().on('click', start).html('START')

doButtonStop = ->
  $('#btn').off().on('click', stop).html('STOP')

doButtonEnable = ->
  $('#btn').prop('disabled', false)

doButtonDisable = ->
  $('#btn').prop('disabled', true)


start = ->
  return if window.speedDecrease isnt false
  clearInterval window.timer if window.timer
  return if window.alternatives.length <= 0

  window.speed = window.CONST.SPEED_RAD 
  window.timer = setInterval(rotateRoulette, 1000 / window.CONST.FPS)
  doButtonStop()

stop = ->
  return if window.timer is false
  return if window.speedDecrease isnt false
  doButtonDisable()

  radLength = 2 * Math.PI * randf(1.0, 2.0)

  window.speedDecrease = (window.CONST.SPEED_RAD - window.CONST.SPEED_RAD_ENDING) / radLength

rotateRoulette = ->
  r = $('#roulette_join')
  now = +(new Date())
  # 最初のスロー
  if window.speedDecrease isnt false and window.endingLimit is false
    window.speed -= window.speedDecrease / window.CONST.FPS
  # 粘りのスロー
  else if window.speedDecrease isnt false and now < window.endingLimit
    window.speed -= window.speedDecrease / window.CONST.FPS / 2
  return ending() if window.speed <= window.CONST.SPEED_RAD_ENDING and window.endingLimit is false
  return result() if window.speed <= 0
  increaseRad = (window.speed / window.CONST.FPS) * (if window.CONST.ROLL_DIRECTION_IS_CLOCK then 1 else -1)
  window.rotate = normalize(window.rotate + increaseRad)
  r.css('transform', 'rotate('+window.rotate+'rad)')

# 最後の粘り
ending = ->
  window.speed = window.CONST.SPEED_RAD_ENDING
  now = +(new Date())
  window.endingLimit = rand(now+3000, now+7000)

result = ->
  clearInterval window.timer if window.timer
  window.timer = false
  window.speedDecrease = false
  window.endingLimit = false
  doButtonStart()
  doButtonEnable()

generateRoulette = ->
  alts = []
  emptyMessage = false
  $('#alternatives').val().split("\n").forEach (v)->
    alts.push v.trim() if v.trim() isnt ''
  if alts.length <= 0
    emptyMessage = '''
                   選択肢を1つ以上
                   入れてください
                   '''
    alts.push emptyMessage

  $('canvas').remove()

  w = $('#roulette_join').width()
  h = $('#roulette_join').height()

  alts.forEach (text, index)->
    baseRad  = 2 * Math.PI / alts.length
    startRad = 2 * Math.PI * (3/4) - (baseRad / 2)

    c = 
    $('<canvas width="'+w+'" height="'+h+'">')
    .css({
      left: 0
      top: 0
      transform: 'rotate('+(baseRad*index)+'rad)'
    })
    .drawSlice({
      fillStyle: '#'+Math.floor(Math.random()*16777215).toString(16),
      x: 0
      y: 0
      start: startRad
      end: startRad + baseRad
      fromCenter: false
      inDegrees: false
      radius: w / 2
      ccw: false
      mask: true
    })
    .drawText({
      fillStyle: '#9cf'
      strokeStyle: '#25a'
      strokeWidth: 2
      x: 50
      y: (h - window.CONST.FONT_SIZE)/2
      fontSize: window.CONST.FONT_SIZE
      fontFamily: 'Verdana, sans-serif'
      text: text
      align: 'left'
      fromCenter: false
    })
    .restoreCanvas()

    $('#roulette_join').append c

  window.rotate = 0
  window.speedDecrease = false
  window.endingLimit = false
  if emptyMessage is false
    window.alternatives = alts
  else
    window.alternatives = []
  true

rand = (min, max)->
  Math.floor(Math.random() * (max - min + 1)) + min

randf = (min, max)->
  Math.random() * (max - min) + min

normalize = (num, min = 0, max = 2 * Math.PI)->
  range = Math.abs(max - min)
  if num < min
    num += range * Math.ceil(Math.abs(num - min) / range)
  else if max <= num
    num -= range * (Math.floor(Math.abs(num - max) / range)+1)
  num