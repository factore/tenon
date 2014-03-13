class Tenon.features.tenonContent.LibraryFilter
  constructor: ->
    $(document).on('keyup', '.tenon-library input.filter', @filter)

  filter: =>
    val = $('.tenon-library input.filter').val()
    if val == ''
      @_clearFilter()
    else
      @_hideNonMatched(val)

  _hideNonMatched: (val) =>
    $('.tenon-library a.add_fields').hide()
    $('.tenon-library a.add_fields[data-searchable-title*="' + val.toLowerCase() + '"]').show()

  _clearFilter: =>
    $('.tenon-library a.add_fields').show()