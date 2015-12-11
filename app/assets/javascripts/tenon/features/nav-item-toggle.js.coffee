class Tenon.features.NavItemToggle
  constructor: ->
    $('.nav-item-toggle').on('click', @_toggle)

  _toggle: (e) ->
    e.preventDefault()
    $(e.currentTarget).closest('li').toggleClass('open')
