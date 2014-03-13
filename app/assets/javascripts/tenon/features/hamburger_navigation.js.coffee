class Tenon.features.HamburgerNavigation
  constructor: ->
    @$navigation = $('.nav-holder, .sidebar-container')
    @$head = $('.util-nav')
    @$toggle = @$head.find('.hamburger a')
    @openClass = 'mobile-open'

    # listeners
    @$toggle.on('click', @toggleNavigation)

  toggleNavigation: (e) =>
    e.preventDefault()
    if @$toggle.hasClass(@openClass)
      @_closeNavigation()
    else
      @_openNavigation()

  _closeNavigation: () =>
    @$toggle.removeClass(@openClass)
    @$navigation.removeClass(@openClass)

  _openNavigation: () =>
    @$toggle.addClass(@openClass)
    @$navigation.addClass(@openClass)
