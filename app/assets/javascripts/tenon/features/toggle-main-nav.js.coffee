class Tenon.features.ToggleMainNav
  constructor: ->
    @hasStorage = typeof(Storage) != "undefined"
    if @hasStorage
      isOpen = localStorage.getItem('main-nav-open')
      $('body').addClass('main-nav-open') if isOpen

    $('.toggle-main-nav').on('click', @_toggle)

  _toggle: =>
    $('body').toggleClass('main-nav-open')
    console.log @hasStorage
    @_storeChange() if @hasStorage

  _storeChange: ->
    if $('body').hasClass('main-nav-open')
      localStorage.setItem('main-nav-open', true)
    else
      localStorage.removeItem('main-nav-open')
