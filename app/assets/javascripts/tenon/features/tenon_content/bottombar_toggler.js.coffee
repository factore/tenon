class Tenon.features.tenonContent.BottombarToggler
  constructor: (@$container) ->
    @_toggleBottombars()
    $('.tenon-content').on('cocoon:after-insert', @_toggleBottombars)
    $('.tenon-content').on('cocoon:after-remove', @_toggleBottombars)

  _toggleBottombars: =>
    # Hide them all
    @$container.find('.tn-tc-bottombar').hide()

    # Then show the one in the last visible row
    @$container
      .find('.tn-tc-row:visible:last')
      .find('.tn-tc-bottombar')
      .show()