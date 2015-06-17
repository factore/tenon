class Tenon.features.tenonContent.ColumnSwap
  constructor: (@$container) ->
    $(document).on('click', '.column-image .swap-sides', @_swapColumns)
    $(document).on('click', '.wrapped-image .swap-sides', @_swapWrapped)

  _swapColumns: (e) =>
    e.preventDefault()
    @$row = @_getRow(e)
    @_swapDOM()
    @_savePositions()
    @_saveRowType()

  _swapWrapped: (e) =>
    e.preventDefault()
    @$row = @_getRow(e)
    @$row.find('.tn-tc-asset-field').toggleClass('left').toggleClass('right')
    @_saveRowType()

  _swapDOM: =>
    $pieces = @$row.find('.tn-tc-piece')
    $($pieces[0]).insertAfter($($pieces[1]))
    $pieces.toggleClass('omega')

  _saveRowType: =>
    $input = @$row.find('input[name$="[row_type]"]')
    if $input.val() == "LeftImageRightText"
      $input.val("LeftTextRightImage")
    else if $input.val() == "LeftTextRightImage"
      $input.val("LeftImageRightText")
    else if $input.val() == "LeftWrappedImageWithText"
      $input.val("RightWrappedImageWithText")
    else if $input.val() == "RightWrappedImageWithText"
      $input.val("LeftWrappedImageWithText")

  _savePositions: =>
    # Note: run the find again to get the pieces in their new order
    $.each @$row.find('.tn-tc-piece'), (i, piece) ->
      $(piece).find('input[name$="[position]"]').val(i)

  _getRow: (e) =>
    $(e.currentTarget)
      .closest('.image-controls')
      .data('image')
      .closest('.tn-tc-row')