window.CONFIG = 
  all_char_num : [4..16].concat [32, 64]
  upper_char_num : [0..8]
  lower_char_num : [0..8]
  int_char_num : [0..8]
  sp_char_num : [0..8]
  
  sp_char_set : [
    ''
    '_'
    '_[]()'
    '_[]()!?@:;,.+-*/'
  ]

window.GLOBAL = 
  CLIPBOARD : null

$().ready(
  ->
    initialize()
    defGenerate()
)


initialize = ->
  for id, content of CONFIG
    select = $('#'+id)
    select.html('')
    for v in content
      select.append(
        $('<option>').val(v).html(v)
      )
    # 変化したらクッキー設定
    select.on(
      'change'
      ->
        val = $(this).val()
        console.log 'cookie ['+$(this).attr('id')+'] '+val
        $.cookie($(this).attr('id'), val, { expires: 365*100 });
    )
    $('#no_'+id).on(
      'change'
      ->
        val = if $(this).prop('checked') then 1 else 0
        console.log 'cookie ['+$(this).attr('id')+'] '+val
        $.cookie($(this).attr('id'), val, { expires: 365*100 });
    )
    # クッキーの値を入れる
    val = if $.cookie(id)? then $.cookie(id) else content[0]
    select.val(val)
    $('#no_'+id).prop('checked', true) if $.cookie('no_'+id)? and Number($.cookie('no_'+id)) is 1

defGenerate = ->
  $('#generate').on(
    'click'
    ->
      resArray = []

      allCharNum = Number $('#all_char_num').val()
      upperMin = Number $('#upper_char_num').val()
      lowerMin = Number $('#lower_char_num').val()
      intMin = Number $('#int_char_num').val()
      spMin = Number $('#sp_char_num').val()
      notUp = $('#no_upper_char_num').prop('checked')
      notLow = $('#no_lower_char_num').prop('checked')
      notInt = $('#no_int_char_num').prop('checked')
      notSp = $('#sp_char_set').val() is ''
      spMin = 0 if notSp
      restNum = allCharNum - (upperMin + lowerMin + intMin + spMin)
      return if restNum < 0
      
      allSet = []

      unless notUp
        upperSet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split('')
        allSet = allSet.concat upperSet
        resArray.push upperSet[mt_rand(0, upperSet.length-1)] for i in [0...upperMin]

      unless notLow
        lowerSet = "abcdefghijklmnopqrstuvwxyz".split('')
        allSet = allSet.concat lowerSet
        resArray.push lowerSet[mt_rand(0, lowerSet.length-1)] for i in [0...lowerMin]

      unless notInt
        intSet = "0123456789".split('')
        allSet = allSet.concat intSet
        resArray.push intSet[mt_rand(0, intSet.length-1)] for i in [0...intMin]

      unless notSp
        spSet = $('#sp_char_set').val().split('')
        allSet = allSet.concat spSet
        resArray.push spSet[mt_rand(0, spSet.length-1)] for i in [0...spMin]

      resArray.push allSet[mt_rand(0, allSet.length-1)] for i in [0...restNum]

      password = resArray.shuffle().join('')
      $('#passwords').prepend(
        $('<div>').append(
          $('<span>').html(password).attr('data-clipboard-text', password).on 'click', ->
            $('.copied').removeClass('copied')
            $(this).addClass('copied')
        ).addClass('password')
      )
      window.GLOBAL.CLIPBOARD.destroy() if window.GLOBAL.CLIPBOARD isnt null
      window.GLOBAL.CLIPBOARD = new Clipboard('.password span')

  )
