$(document).on 'pageinit', ->
  $('#sign-in-dialog').on 'pageinit', ->
    $('#submit').click ->
      alert 'I wanna sign in!'
