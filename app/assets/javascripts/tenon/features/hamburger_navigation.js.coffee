class Tenon.features.HamburgerNavigation
  constructor: ->
    @$navigation = $('.nav-holder, .sidebar-container')
    @$head = $('.util-nav')
    @$toggle = @$head.find('.hamburger a')
    @openClass = 'mobile-open'

    # listeners
    @$toggle.on('click', @toggleNav)
    $(document).on('click', '.sidebar-container.mobile-open a', @_closeNav)

  toggleNav: (e) =>
    e.preventDefault()
    if @$toggle.hasClass(@openClass)
      @_closeNav()
    else
      @_openNav()

  _closeNav: () =>
    @$toggle.removeClass(@openClass)
    @$navigation.removeClass(@openClass)

  _openNav: () =>
    @$toggle.addClass(@openClass)
    @$navigation.addClass(@openClass)
