class Tenon.features.HeaderMenu
  constructor: ->
    $('.header-menu > a').on('click', @toggleMenu)
    $(document).on('click', @hideMenu)

  toggleMenu: (e) =>
    e.preventDefault()
    e.stopPropagation()
    $(e.currentTarget).closest('.header-menu').toggleClass('active')
    $(e.currentTarget).find('i').toggleClass('fa-times fa-' + $(e.currentTarget).data('icon'))

  hideMenu: (e) =>
    # unless $(e.target).is('.header-menu ul *, .header-menu ul')
    for headerMenu in $('.header-menu')
      $hm = $(headerMenu)
      $a = $hm.find('a:first')
      $hm.removeClass('active')
      $a.find('i')
        .removeClass('fa-times')
        .addClass('fa-' + $a.data('icon'))
