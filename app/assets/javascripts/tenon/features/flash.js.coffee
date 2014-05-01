class Tenon.features.Flash
  constructor: ->
    @$flash = $('.flash')
    @_showFlash()
    $(document).on('click', '#flash-dismiss', @_dismissFlash)

  _showFlash: =>
    @$flash.insertAfter($('header'))
    @$flash.show()

  _dismissFlash: =>
    @$flash.fadeOut()
