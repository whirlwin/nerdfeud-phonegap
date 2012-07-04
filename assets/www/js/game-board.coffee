$('#game-board').live 'pageinit', ->
  $('.letter').draggable
    opacity: 0.35,
    revert:  true,
    snap:    true,
    zIndex:  2700

  $('.column').droppable
    accept:    '.letter',
    drop:      (e, ui) ->
      $(this).append ui.draggable
