class Tenon.features.tenonContent.Aesthetics
  constructor: (@$container) ->
    @$wrap = @$container.closest('.tn-tc-wrap')
    @$container.imagesLoaded(@_applyAesthetics)
    $(window).on('resize', @_applyAesthetics)
    $(document).on('cocoon:after-insert', '.tenon-content', @_applyAesthetics)
    @$container.on('tenon.asset_attached', '.tn-tc-asset-field', @_applyAesthetics)
    @$container.on('tenon.content.column_resized', 'div', @_applyAesthetics)
    @$wrap.on('tenon.content.popped', @_applyAesthetics)
    @$wrap.on('tenon.content.resized', @_applyAesthetics)
    @$container.on('keyup', '.editable-text', $.debounce(350, @_applyAesthetics))

  _applyAesthetics: =>
    if @$wrap.hasClass('mobile-breakpoint')
      @$container.find('.editable-text').css('min-height', '')
    else
      @_setMinimumEditorHeightWithImage()
      @_setMinimumWrappedEditorHeight()

  _setMinimumEditorHeightWithImage: =>
    $.each @$container.find('.tn-tc-image-and-text, .tn-tc-multi-text'), (i, row) ->
      $images = $(row).find('.image, .editable-text')
      $images.css('min-height', '0px')
      heights = $.map($images, (img, i) -> $(img).outerHeight())
      height = Math.max.apply(Math, heights)
      $(row).find('.editable-text').css('min-height', height)

  _setMinimumWrappedEditorHeight: =>
    $.each @$container.find('.tn-tc-wrapped-image-with-text'), (i, row) ->
      height = $(row).find('.image').height();
      $(row).find('.editable-text').css('min-height', height + 20)