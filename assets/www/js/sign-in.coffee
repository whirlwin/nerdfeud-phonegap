$(document).on 'pageinit', ->
  $('#sign-in-dialog').on 'pageinit', ->
    $('#submit').click ->
      signIn()

signIn = ->
  $.getJSON 'misc/app.json.properties', (data) ->
    alert(JSON.stringify data)
