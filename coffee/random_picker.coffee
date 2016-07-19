$().ready ->
  $('#pick').on 'click', ->
    times = Number $('#times').val()
    isUnique = $('#unique').prop('checked')
    items = []
    for val in $('#items').val().replace(/(\r|\n|\r\n)/, "\n").split("\n")
      items.push val if val isnt ''
    items.shuffle()

    res = []
    if isUnique
      for i in [0...times]
        res.push items.pop() if items.length > 0
    else
      for i in [0...times]
        res.push items[mt_rand(0, items.length-1)]
    $('#result').val res.join("\n")