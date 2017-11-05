window.CONST =
  FONT_SIZE: 50

$().ready ->
  window.canvas = $('#roulette')
  generateRoulette()

generateRoulette = (alternatives)->
  w = $('#roulette').width()
  h = $('#roulette').height()

  c = window.canvas

  alts = []
  $('#alternatives').text().split("\n").forEach (v)->
    alts.push v.trim() if v.trim() isnt ''

  for index in [0...alts.length]
    text = ''+alts[index]+(Array(9999).join('　'))
    c
    .drawSlice({
      fillStyle: '#'+Math.floor(Math.random()*16777215).toString(16),
      x: 0
      y: 0
      start: 2 * Math.PI * (index / alts.length)
      end: 2 * Math.PI * ((index+1) / alts.length)
      fromCenter: false
      inDegrees: false
      radius: w / 2
      ccw: false
    })
    .drawText({
      fillStyle: '#9cf'
      strokeStyle: '#25a'
      strokeWidth: 2
      x: w/4
      y: (h - window.CONST.FONT_SIZE)/2
      fontSize: window.CONST.FONT_SIZE
      fontFamily: 'Verdana, sans-serif'
      text: text
      align: 'left'
      fromCenter: false
      rotate: 2 * Math.PI * (index / alts.length)
      inDegrees: false
      maxWidth: w/2
      respectAlign: true
    })
    .restoreCanvas()


# ある点からある角度にある距離移動した座標を求める
getMovedPoint:(p, angle, distance)->
  [x, y] = p

  [x + Math.abs(distance) * Math.cos(angle), y + Math.abs(distance) * Math.sin(angle)]

# p を basePoint を基準に angle 回転した座標を求める
getRotatePoint:(p, angle, basePoint = [0, 0])->
  [x, y] = p
  [baseX, baseY] = basePoint

  x -= baseX
  y -= baseY

  movedX = x*Math.cos(angle) - y*Math.sin(angle)
  movedY = x*Math.sin(angle) + y*Math.cos(angle)
  [movedX + baseX, movedY + baseY]