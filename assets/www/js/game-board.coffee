$('#game-board').live 'pageinit', ->
  counter = 0

  $('.letter').draggable
    opacity: 0.35,
    revert:  true,
    snap:    true,
    zIndex:  2700

  $('.column').droppable
    accept: '.letter',
    greedy: true,
    drop:   (e, ui) ->
        $(this).droppable 'disable'
