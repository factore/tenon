class Tenon.features.tenonContent.StretchToFit
  constructor: (@$container) ->
    $(document).on('click', '.medium-editor-action.resize-image', @resizeImage)

  resizeImage: (e) =>
    e.preventDefault()
    @$image = @_getImage(e)
    @_applyClass()

  _applyClass: () =>
    if @$image.hasClass('stretch')
      @$image.removeClass('stretch')
    else
      @$image.addClass('stretch')

  _getImage: (e) =>
    $(e.currentTarget)
      .closest('.image-controls')
      .data('image')
