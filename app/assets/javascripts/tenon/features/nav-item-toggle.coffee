class Tenon.features.NavItemToggle
  constructor: ->
    $('.main-nav__link-toggle')
      .on('click', @_toggle)

  _toggle: (e) ->
    e.preventDefault()
    $(e.currentTarget).closest('.main-nav__item')
      .toggleClass('open')
