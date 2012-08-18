providers = {}

signInDialog = $('#sign-in-dialog')

signInDialog.live 'pageinit', ->
  refreshComponents()

  $.getJSON 'misc/credentials.json', (data) -> providers = data

  $('#sign-in-form').submit ->
    switch $('input[name=method]:checked', $ this).val()
      when 'facebook' then finish 'foobar' #*signInToFacebook()

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
    token = token[1].slice 1 unless token == null

    finish token unless token == null

finish = (token) ->
  window.plugins.childBrowser.close()

  # sessionStorage vs localStorage
  localStorage.setItem 'token', token

  $('#sign-in-dialog').dialog 'close'
  $.mobile.changePage '#game-list'
