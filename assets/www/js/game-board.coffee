$('#game-board').live 'pageinit', ->

  $('.letter').draggable
    opacity: 0.35,
    revert:  true,
    snap:    true,
    zIndex:  2700

  $('.column').droppable
    greedy: true,
    drop:   (e, ui) ->
        $(this).droppable 'option', 'accept', ui.draggable
        $(this).append ui.draggable
    out:    (e, ui) ->
        $(this).droppable 'option', 'accept', '.letter'
