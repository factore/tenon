class Tenon.features.tenonContent.StretchToFill
  stretchClass: 'tn-tc-fields__image-container--stretch'

  constructor: (@$container) ->
    $(document).on('click', '.medium-editor-toolbar__action.stretch-to-fill', @stretchImage)

  stretchImage: (e) =>
    e.preventDefault()
    @$button = $(e.currentTarget)
    @$piece = @_getPiece()
    @$imageContainer = @_getImageContainer()
    @_setState()

  _setState: () =>
    if @$imageContainer.hasClass(@stretchClass)
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
      @$imageContainer.addClass(@stretchClass)
    else
      @$imageContainer.removeClass(@stretchClass)

  _setButtonActiveState: () =>
    if @state == true
      @$button.addClass('medium-editor-button-active')
      @$imageContainer.find('.stretch-to-fill').addClass('medium-editor-button-active')
    else
      @$button.removeClass('medium-editor-button-active')
      @$imageContainer.find('.stretch-to-fill').removeClass('medium-editor-button-active')

  _getImageContainer: () =>
    @$button
      .closest('.image-controls')
      .data('image')

  _getPiece: () =>
    @$button
      .closest('.image-controls')
      .data('image')
      .closest('.tn-tc-piece')
