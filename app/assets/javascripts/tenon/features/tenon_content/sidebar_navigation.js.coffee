class Tenon.features.SidebarNavigation
  constructor: ->
    @$navigation = $('.sidebar-container')
    @$toggle = $('#sidebar-toggle')
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
    @$toggle.find('i').toggleClass('fa-caret-square-o-down fa-times')
    @$toggle.removeClass(@openClass)
    @$navigation.removeClass(@openClass)

  _openNav: () =>
    @$toggle.find('i').toggleClass('fa-caret-square-o-down fa-times')
    @$toggle.addClass(@openClass)
    @$navigation.addClass(@openClass)
