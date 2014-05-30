class Tenon.features.tenonContent.ImageLinks
  constructor: (@$container) ->
    $(document).on('click', '.image-controls .add-link', @buildLinkForm)

  buildLinkForm: (e) =>
    @$button = $(e.currentTarget)
    @$image = @_getImage(e)
    @$form = @$image.find('.link-form')
    @$visibleForm = @$form.clone()
    @_showLinkForm()
    @_bindLinkForm()
    Tenon.activeImageControlsLinkForm = this

  saveForm: =>
    @$form.replaceWith(@$visibleForm)
    @_setButtonActiveState()
    Tenon.activeImageControls.showControls()

  _showLinkForm: (e) =>
    Tenon.activeImageControls.hideControls()
    @$visibleForm.appendTo('body').css
      left: @_leftOffset(Tenon.activeImageControls.previousX)
      top: Tenon.activeImageControls.previousY - 75
      display: 'block'

  _getImage: (e) =>
    $(e.currentTarget)
      .closest('.image-controls')
      .data('image')

  _leftOffset: (left) =>
    if $(window).width() < 641
      (($(window).width() - @$visibleForm.width()) / 2) + 'px'
    else
      left - (@$visibleForm.width() / 2) + 'px'

  _bindLinkForm: =>
    @$visibleForm.on('keyup', 'input', @_formFilled)
    @$visibleForm.on('click', '.medium-editor-cancel', @_cancel)

  _formFilled: (e) =>
    @saveForm() if e.keyCode == 13

  _cancel: (e) =>
    e.preventDefault()
    @$visibleForm.remove()

  _setButtonActiveState: (e) =>
    if @$visibleForm.find('input').val() != ''
      @$button.addClass('medium-editor-button-active')
      @$image.find('.add-link').addClass('medium-editor-button-active')
    else
      @$button.removeClass('medium-editor-button-active')
      @$image.find('.add-link').removeClass('medium-editor-button-active')