class Tenon.features.HeaderMenu
  constructor: ->
    $('.header-menu > a').on('click', @toggleMenu)
    $('.header-menu ul a').on('click', @preventHide)
    $(document).on('click', @hideMenu)

  toggleMenu: (e) =>
    e.preventDefault()
    e.stopImmediatePropagation()
    $(e.currentTarget).closest('.header-menu').toggleClass('active')

  hideMenu: =>
    $('.header-menu').removeClass('active')

  preventHide: (e) -> e.stopImmediatePropagation()