class Tenon.features.ToggleMainNav
  constructor: ->
    @hasStorage = typeof(Storage) != "undefined"
    @_checkStorage() if @hasStorage

    $('.toggle-drawer').on('click', @_toggle)

  _toggle: (e) =>
    e.preventDefault()
    target = $(e.currentTarget).data('target')

    $('body').toggleClass("#{target}-open")
    @_storeChange(target) if @hasStorage

  _storeChange: (target) ->
    if $('body').hasClass("#{target}-open")
      localStorage.setItem("#{target}-open", true)
    else
      localStorage.removeItem("#{target}-open")

  _checkStorage: ->
    navIsOpen = localStorage.getItem('main-nav-drawer--open')
    $('body').addClass('main-nav-drawer--open') if navIsOpen
