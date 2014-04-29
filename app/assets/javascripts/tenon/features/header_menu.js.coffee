class Tenon.features.HeaderMenu
  constructor: ->
    $('.header-menu > a').on('click', @toggleMenu)
    $(document).on('click', @hideMenu)

  toggleMenu: (e) =>
    e.preventDefault()
    e.stopPropagation()
    $(e.currentTarget).closest('.header-menu').toggleClass('active')

  hideMenu: (e) =>
    # unless $(e.target).is('.header-menu ul *, .header-menu ul')
    $('.header-menu').removeClass('active')
