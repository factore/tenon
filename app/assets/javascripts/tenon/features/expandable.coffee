class Tenon.features.Expandable
  constructor: ->
    # listen!
    $(document).on 'click', '.expandable .expand', @_toggleCode

  _toggleCode: (e) =>
    e.preventDefault()
    $target = $(e.currentTarget).closest('.expandable')
    $target.toggleClass('is-expanded')
