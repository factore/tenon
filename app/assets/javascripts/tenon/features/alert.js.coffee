class Tenon.features.Alert
  constructor: ->
    @$alert = $('.alert')
    @_showAlert()
    $(document).on('click', @_dismissAlert)

  _showAlert: =>
    @height = @$alert.outerHeight()
    @$alert
      .css('bottom', '-' + @height + "px")
      .show()
      .animate({bottom: 0}, 250)

  _dismissAlert: =>
    @height = @$alert.outerHeight()
    @$alert
      .animate( {bottom: @height * -1}, 250 )

