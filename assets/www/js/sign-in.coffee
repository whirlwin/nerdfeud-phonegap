providers        = {}

signInDialog = $('#sign-in-dialog')

signInDialog.live 'pageinit', ->
  refreshComponents()

  $.getJSON 'misc/credentials.json', (data) -> providers = data

  $('#sign-in-form').submit ->


    switch $('input[name=method]:checked', $ this).val()
      when 'facebook' then dbHelper.init ->
        dbHelper.retrieveToken 'facebook', signInToFacebook

    false

refreshComponents = ->
  signInDialog.live 'pageshow', ->
    $('#sign-in-form :input[type="radio"]').each ->
      $(this).checkboxradio 'refresh'

signInToFacebook = ->

  window.plugins.childBrowser.showWebPage(
    "http://wwww.facebook.com/dialog/oauth?
client_id=#{providers['facebook'].appId}
&redirect_uri=http://example.org
&response_type=token
&display=touch",
    { showLocationBar: false })

  bindFacebookLocationChange()


bindFacebookLocationChange = ->
  window.plugins.childBrowser.onLocationChange = (loc) ->

    # Extract the token
    token = loc.match /http:\/\/example.org\/#access_token=(\w+)&.*/

    unless token == null
      window.plugins.childBrowser.close()

      token = token[1]

      dbHelper.persistToken 'facebook', token, ->
        postUserInformation token, ->
          finish 'facebook', token

postUserInformation = (token, f) ->
  $.getJSON "https://graph.facebook.com/me&access_token=#{token}", (user) ->
    alert JSON.stringify(user)

finish = (provider, token) ->
  localStorage.setItem "token#{provider}", token

  $.mobile.loading 'hide'
  $('#sign-in-dialog').dialog 'close'
  $.mobile.changePage '#game-list'

dbHelper = (->
  db = null

  { 'init': (f) ->
      db = window.openDatabase 'nerdfeud', '1.0', 'nerdfeud', 1000000
      f()

    ,'persistToken': (provider, token, f) ->
      db.transaction (tx) ->
        tx.executeSql 'DROP TABLE IF EXISTS tokens'
        tx.executeSql 'CREATE TABLE IF NOT EXISTS tokens (provider, token)'
        tx.executeSql "INSERT INTO tokens (provider, token) VALUES (\"#{provider}\", \"#{token}\")"
      ,(tx, err) ->
        alert JSON.stringify(tx)
      ,->
        f()

    ,'retrieveToken': (provider, signIn) ->
      db.transaction (tx) ->
        tx.executeSql "SELECT * FROM tokens WHERE provider = \"#{provider}\"", [], (tx, tokens) ->
          finish 'provider', tokens[0]

        ,(tx, err) ->
          $.mobile.loading 'show', {
            text:        'Loading',
            textVisible: true,
            theme:       'a'
          }

          # If no token was found, sign in
          signIn()
  }
)()
