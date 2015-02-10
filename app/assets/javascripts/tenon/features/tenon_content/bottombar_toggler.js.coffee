class Tenon.features.tenonContent.BottombarToggler
  constructor: (@$container) ->
    @_toggleBottombars()
    $(document).on('cocoon:after-insert', '.tenon-content', @_toggleBottombars)
    $(document).on('cocoon:after-remove', '.tenon-content', @_toggleBottombars)

  _toggleBottombars: =>
    # Hide them all
    @$container.find('.tn-tc-bottombar').hide()

    # Then show the one in the last visible row
    @$container
      .find('.tn-tc-row:visible:last')
      .find('.tn-tc-bottombar')
      .show()