class Tenon.features.HamburgerNavigation
  constructor: ->
    @$navigation = $('.nav-holder, .hamburger-toggle')
    @$head = $('util-nav')
    @$toggle = @$head.find('.hamburger a')
    @openClass = 'mobile-open'

    # listeners
    @$toggle.on('click', @toggleNav)
    $(document).on('click', '.nav-holder.mobile-open a', @_closeNav)

  toggleNav: (e) =>
    e.preventDefault()
    @$toggle.find('i').toggleClass('fa-bars fa-times')
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
