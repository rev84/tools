window.CONST = 
  LS_FONT_SIZE : 'telopper_font_size'
  LS_SPEED : 'telopper_speed'
  LS_FONT_FAMILY : 'telopper_font_family'
  LS_END_SPACE : 'telopper_end_space'

$().ready ->
  $('#execute').on 'click', scroll
  
  $('#font_family').on 'change', ->
    Utl.setLs window.CONST.LS_FONT_FAMILY, $(@).val()
  $('#font_family').val(Utl.getLs(window.CONST.LS_FONT_FAMILY)) if Utl.getLs(window.CONST.LS_FONT_FAMILY) isnt null

  $('#end_space').on 'change', ->
    Utl.setLs window.CONST.LS_END_SPACE, $(@).val()
  $('#end_space').val(Utl.getLs(window.CONST.LS_END_SPACE)) if Utl.getLs(window.CONST.LS_END_SPACE) isnt null

  $('#font_size').on 'change', ->
    Utl.setLs window.CONST.LS_FONT_SIZE, $(@).val()
  $('#font_size').val(Utl.getLs(window.CONST.LS_FONT_SIZE)) if Utl.getLs(window.CONST.LS_FONT_SIZE) isnt null

  $('#speed').on 'change', ->
    Utl.setLs window.CONST.LS_SPEED, $(@).val()
  $('#speed').val(Utl.getLs(window.CONST.LS_SPEED)) if Utl.getLs(window.CONST.LS_SPEED) isnt null


scroll = ->
  fontSize = Number($('#font_size').val())

  $('#scroll_space').css('height', ''+(fontSize*1.5)+'px')
  $('#scroll_space').html('')

  generateString(content)

generateString = ()->
  divWidth = $('#scroll_space').width()
  fontSize = Number($('#font_size').val())
  speed = Number($('#speed').val())
  content = $('#content').val().replace(/\n/gi, '&nbsp;') + '&nbsp;'.repeat(Number($('#end_space').val()))
  color = $('#color').val()
  fontFamily = $('#font_family').val()
  isOutline = $('#outline').prop('checked')

  span = $('<span>').addClass('scroll_body')
                    .html(content)
                    .css('font-size', ''+fontSize+'px')
                    .css('left', ''+divWidth+'px')
                    .css('color', color)
                    .css('font-family', fontFamily)
                    .attr('data-generated', 0)
  span.addClass('outline') if isOutline
  $('#scroll_space').append(span)

  spanWidth = span.width()
  mSec = (divWidth+spanWidth) / speed * 1000


  span.animate({
    left : '-'+spanWidth+'px'
  }, {
    duration : mSec
    easing : 'linear'
    step : ->
      divWidth = $('#scroll_space').width()
      myWidth = $(@).width()
      left = Number($(@).css('left').replace('px', ''))
      #console.log('bool:'+(left + myWidth < divWidth)+', left+myWidth:'+(left + myWidth)+', divWidth:'+divWidth)
      if left + myWidth < divWidth and (Number($(@).attr('data-generated')) is 0)
        $(@).attr('data-generated', 1)
        window.generateString()
    complete : ->
      $(@).remove()
  })
