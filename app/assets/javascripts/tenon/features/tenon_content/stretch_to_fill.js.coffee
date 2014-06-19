class Tenon.features.tenonContent.StretchToFill
  constructor: (@$container) ->
    $(document).on('click', '.medium-editor-action.stretch-to-fill', @stretchImage)

  stretchImage: (e) =>
    e.preventDefault()
    @$piece = @_getPiece(e)
    @$image = @_getImage(e)
    @_applyClass()

  _applyClass: () =>
    if @$image.hasClass('stretch')
      @$image.removeClass('stretch')
      @_saveState(false)
    else
      @$image.addClass('stretch')
      @_saveState(true)

  _getImage: (e) =>
    $(e.currentTarget)
      .closest('.image-controls')
      .data('image')

  _getPiece: (e) =>
    $(e.currentTarget)
      .closest('.image-controls')
      .data('image')
      .closest('.tn-tc-piece')

  _saveState: (state) =>
    @$piece.find('input[name$="[stretch_to_fill]"]').val(state)
