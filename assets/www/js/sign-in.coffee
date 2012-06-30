$(document).on 'pageinit', ->
  $('#sign-in-dialog').on 'pageinit', ->
    $('#submit').click ->
      signIn()

signIn = ->
  $.getJSON 'misc/app.json.properties', (data) ->
    $.ajax({
      url: """
           https://graph.facebook.com/oauth/access_token?
           client_id=#{data.APP_ID}&client_secret=#{data.APP_SECRET}
           """,
      success: (s) -> alert('Succ: ' + s),
      error: (xhr) -> alert(JSON.stringify(xhr))
    })
