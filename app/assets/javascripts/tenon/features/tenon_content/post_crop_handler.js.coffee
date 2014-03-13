class Tenon.features.tenonContent.PostCropHandler
  constructor: (@$link, @asset) ->
    $('.asset-cropping').remove()
    $image = @$link.closest('.image-controls').data('image')
    @$piece = $image.closest('.tn-tc-piece')
    @_replaceImage();
    @_updateFields();

  _replaceImage: =>
    $img = @$piece.find('img').attr('src', @asset.style_urls.medium)

    # We have to make sure the image loads before we fire the trigger
    # For some reason the imagesLoaded function is not working so
    # let's kick it OLD SCHOOL
    img = new Image()
    img.onload = =>
      @$piece.closest('.asset-field').trigger('tenon.asset_attached')
    img.src = $img.attr('src')

  _updateFields: =>
    @$piece.find('.asset-id-field').val(@asset.id)
    @$link.data('asset-id', @asset.id)