signInDialog = $('#sign-in-dialog')

providers = {}

refreshComponents = ->
  signInDialog.live 'pageshow', ->
    $('#sign-in-form :input[type="radio"]').each ->
      $(this).checkboxradio 'refresh'

signInToFacebook = ->
  alert true

signInDialog.live 'pageinit', ->
  refreshComponents()
  getProviders()

  $('#sign-in-form').submit ->

    checkedValue = $('input[name=method]:checked', $ this).val()
    appId        = providers[checkedValue].appId

    eval "signInTo#{checkedValue[0].toUpperCase() + checkedValue[1..]}()"

    false

getProviders = ->
  $.getJSON 'misc/credentials.json', (data) ->
    providers = data


