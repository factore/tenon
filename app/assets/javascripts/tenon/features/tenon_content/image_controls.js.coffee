class Tenon.features.tenonContent.ImageControls
  constructor: ($container) ->
    $(document).on('click', @hideControls)
    $container.on('click', '.image img', @toggleControls)

  toggleControls: (e) =>
    @hideControls()
    @_buildControls(e)
    e.stopImmediatePropagation()

  showControls: (x, y) =>
    x ||= @previousX
    y ||= @previousY
    @$controls.appendTo('body').css
      left: @_leftOffset(x)
      top: y + 'px'
      display: 'block'

    @previousX = x
    @previousY = y

  hideControls: =>
    $('body > .image-controls').hide()
    $('.tooltip').remove()

  _removeControls: =>
    $('body > .image-controls, body > .link-form').remove()
    delete Tenon.activeImageControls

  _buildControls: (e) =>
    @_removeControls()
    Tenon.activeImageControls = this
    $img = $(e.currentTarget)
    @$image = $img.closest('.image')
    @$controls = @$image.find('.image-controls').clone()
    @_tagControls()
    @showControls(e.pageX, e.pageY)

  _tagControls: =>
    # Add some data for use in operations
    @$controls.data('image', @$image)
    @$controls.find('.replace-image')
      .data('asset-field', @$image.closest('.tn-tc-asset-field'))

    # Add some classes for targeting and styling
    if @$image.closest('.tn-tc-wrapped-image-with-text').length > 0
      @$controls.addClass('wrapped-image', true)
    else if @$image.closest('.full-width-image').length > 0
      @$controls.addClass('full-width-image')
    else if @$image.closest('.three-column-image').length > 0
      @$controls.addClass('three-column-image')
    else if @$image.closest('.four-column-image').length > 0
      @$controls.addClass('four-column-image')
    else if @$image.closest('.stacked-image-and-text').length > 0
      @$controls.addClass('stacked-image-and-text')
    else
      @$controls.addClass('column-image')

  _leftOffset: (left) =>
    if $(window).width() < 641
      (($(window).width() - @$controls.width()) / 2) + 'px'
    else
      left - (@$controls.width() / 2) + 'px'