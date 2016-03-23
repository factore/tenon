class Tenon.features.tenonContent.BottombarToggler
  constructor: (@$container) ->
    @_toggleBottombars()
    $(document).on('cocoon:after-insert', '.tn-tc__rows', @_toggleBottombars)
    $(document).on('cocoon:after-remove', '.tn-tc__rows', @_toggleBottombars)

  _toggleBottombars: =>
    # Hide them all
    @$container.find('.tn-tc-row__bottom-bar').hide()

    # Then show the one in the last visible row
    @$container
      .find('.tn-tc-row:visible:last')
      .find('.tn-tc-row__bottom-bar')
      .show()
