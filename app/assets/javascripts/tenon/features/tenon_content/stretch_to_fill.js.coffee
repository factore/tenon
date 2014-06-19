class Tenon.features.tenonContent.StretchToFill
  constructor: (@$container) ->
    $(document).on('click', '.medium-editor-action.stretch-to-fill', @stretchImage)

  stretchImage: (e) =>
    e.preventDefault()
    @$button = $(e.currentTarget)
    @$piece = @_getPiece(e)
    @$image = @_getImage(e)
    @_setState()

  _setState: () =>
    if @$image.hasClass('stretch')
      @state = false
    else
      @state = true
    @_saveState()

  _saveState: () =>
    @_setFormFieldState()
    @_setImageState()
    @_setButtonActiveState()

  _setFormFieldState: () =>
    @$piece.find('input[name$="[stretch_to_fill]"]').val(@state)

  _setImageState: () =>
    if @state == true
      @$image.addClass('stretch')
    else
      @$image.removeClass('stretch')

  _setButtonActiveState: () =>
    if @state == true
      @$button.addClass('medium-editor-button-active')
      @$image.find('.stretch-to-fill').addClass('medium-editor-button-active')
    else
      @$button.removeClass('medium-editor-button-active')
      @$image.find('.stretch-to-fill').removeClass('medium-editor-button-active')

  _getImage: (e) =>
    @$button
      .closest('.image-controls')
      .data('image')

  _getPiece: (e) =>
    @$button
      .closest('.image-controls')
      .data('image')
      .closest('.tn-tc-piece')
