class Tenon.features.AssetCropping
  constructor: ->
    $(document).on('click', '.asset-crop', @_loadCrop)
    $(document).on('ajax:success', 'form[data-crop-form]', @_saveCrop)
    $(document).on('click', '.save', @_showSpinner)

  _showSpinner: (e) ->
    $('.spinner').fadeIn()

  _loadCrop: (e) =>
    e.preventDefault()
    @$link = $(e.currentTarget)
    href = @$link.attr('href')
    unless href?.length
      href = @$link.data('base-assets-path') + '/'
      href += @$link.data('asset-id') + '/'
      href += 'crop'

    $.get(href, { format: 'html' }, @_startCrop, 'html')


  _startCrop: (data) =>
    Tenon.modals.launchWithOpts(content: data)
    $cropbox = $('#cropbox')

    $("#cropbox").Jcrop
      onChange: @_updateCrop
      onSelect: @_updateCrop
      boxWidth: $(window).width() * 0.8
      boxHeight: $(window).height() * 0.75

  _saveCrop: (e, data) =>
    if @$link.data('post-crop-handler')
      @_sendToHandler(data.record)
    else
      $('.asset-cropping').remove()

  _sendToHandler: (data) =>
    parts = @$link.data('post-crop-handler').split('.')
    method = window
    $(parts).each (i, part) -> method = method[part]
    new method(@$link, data)

  _updateCrop: (coords) ->
    ratio = $('#cropbox').data('width') / $('#cropbox').width()
    $('#asset_crop_x').val(coords.x)
    $('#asset_crop_y').val(coords.y)
    $('#asset_crop_w').val(coords.w)
    $('#asset_crop_h').val(coords.h)
