$('#home').live 'pageinit', ->
  $('#sign-in').click ->
    if navigator.network.connection.type == Connection.NONE
      navigator.notification.alert 'No internet connection detected', null
      false
