$(document).on 'pageinit', ->
  $('#sign-in-dialog').on 'pageinit', ->
    $('#submit').click ->
      getProperties()

getProperties = ->
  $.get 'misc/app.properties', (data) ->
    alert data

signIn = ->
  alert 'foobar'
