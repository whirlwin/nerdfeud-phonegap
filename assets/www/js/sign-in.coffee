providers = {}

signInDialog = $('#sign-in-dialog')

refreshComponents = ->
  signInDialog.live 'pageshow', ->
    $('#sign-in-form :input[type="radio"]').each ->
      $(this).checkboxradio 'refresh'

signInDialog.live 'pageinit', ->
  refreshComponents()
  fetchProviders()

  $('#sign-in-form').submit ->
    switch $('input[name=method]:checked', $ this).val()
      when 'facebook' then signInToFacebook()

    false

fetchProviders = ->
  $.getJSON 'misc/credentials.json', (data) ->
    providers = data

signInToFacebook = ->
  window.plugins.childBrowser.showWebPage(
    "http://wwww.facebook.com/dialog/oauth?
client_id=#{providers['facebook'].appId}
&redirect_uri=http://example.org
&response_type=token
&display=touch",
    { showLocationBar: false })

  window.plugins.childBrowser.onLocationChange = (loc) ->

    # Extract the token
    token = loc.match /http:\/\/example.org\/#access_token=(\w+)&.*/
    token = token[1].slice 1 unless token == null

    finish(token) unless token == null

finish = (token) ->
  window.plugins.childBrowser.close()
