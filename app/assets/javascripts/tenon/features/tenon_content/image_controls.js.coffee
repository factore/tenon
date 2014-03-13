class Tenon.features.tenonContent.ImageControls
  constructor: ($container) ->
    $(document).on('click', @hideControls)
    $container.on('click', '.image img', @toggleControls)

  toggleControls: (e) =>
    @hideControls()
    @_buildControls(e)
    e.stopImmediatePropagation();

  hideControls: =>
    $('body > .image-controls').hide()
    $('.tooltip').remove()

  _removeControls: =>
    $('body > .image-controls').remove()

  _buildControls: (e) =>
    @_removeControls()
    $img = $(e.currentTarget)
    @$image = $img.closest('.image')
    @$controls = @$image.find('.image-controls').clone()
    @_tagControls()
    @_showControls(e.pageX, e.pageY)

  _showControls: (left, top) =>
    @$controls.appendTo('body').css
      left: @_leftOffset(left)
      top: top + 'px'
      display: 'block'

  _tagControls: =>
    # Add some data for use in operations
    @$controls.data('image', @$image)
    @$controls.find('.replace-image')
      .data('asset-field', @$image.closest('.asset-field'))

    # Add some classes for targeting and styling
    if @$image.closest('.wrapped-image-with-text').length > 0
      @$controls.addClass('wrapped-image', true)
    else if @$image.closest('.full-width-image').length > 0
      @$controls.addClass('full-width-image')
    else
      @$controls.addClass('column-image')

  _leftOffset: (left) =>
    if $(window).width() < 641
      (($(window).width() - @$controls.width()) / 2) + 'px'
    else
      left - (@$controls.width() / 2) + 'px'