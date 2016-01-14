class Tenon.features.Styleguide
  constructor: ->
    @$styleguide = $('#styleguide')

    # listen!
    @$styleguide.on 'click', 'code.expandable', @_toggleCode
    
  _toggleCode: (e) =>
    e.preventDefault()
    $target = $(e.currentTarget).closest('code')
    $target.toggleClass('is-expanded')
