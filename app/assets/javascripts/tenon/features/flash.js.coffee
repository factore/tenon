class Tenon.features.Flash
  constructor: ->
    @$flash = $('.flash')
    @_showFlash()
    $(document).on('click', '.flash__dismiss', @_dismissFlash)

  _showFlash: =>
    @$flash.insertAfter($('header'))
    @$flash.show()

  _dismissFlash: (e) =>
    e.preventDefault()
    @$flash.slideUp(250)
