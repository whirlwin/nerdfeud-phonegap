signInDialog = $('#sign-in-dialog')

refreshComponents = ->
  signInDialog.live 'pageshow', ->
    $('#sign-in-form :input[type="radio"]').each ->
      $(this).checkboxradio 'refresh'

signInDialog.live 'pageinit', ->
  refreshComponents()

  $('#submit').click ->
    #signIn()
    # TODO: Create some fancy sign in logic

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
