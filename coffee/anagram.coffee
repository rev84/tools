String::anagrammatize =->
  ary = @.split('')
  ary = ary.shuffle()
  ary.join('')

$().ready ->
  $('#anagrammatize').on 'click', ->
    $('#after').val $('#before').val().anagrammatize()
  $('#before, #after').on 'click', ->
    $(this).select()