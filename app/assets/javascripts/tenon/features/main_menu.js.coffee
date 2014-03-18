class Tenon.features.MainMenu
  constructor: ->
    $('.main-nav').hoverIntent(@_openMenu, @_closeMenu)

  _openMenu: (e) ->
    e.preventDefault()
    $('.nav-holder').addClass('open')

  _closeMenu: (e) ->
    e.preventDefault()
    $('.nav-holder').removeClass('open')