class Tenon.features.tenonContent.PostCropHandler
  constructor: (@$link, @asset) ->
    $image = @$link.closest('.image-controls').data('image')
    @$piece = $image.closest('.tn-tc-piece')
    @_replaceImage()
    @_updateFields()
    Tenon.features.ModalWindows.closeModals()

  _replaceImage: =>
    $img = @$piece.find('img')
    $img.attr('src', @asset.style_urls.medium)
    $img.attr('srcset', '')

    # We have to make sure the image loads before we fire the trigger
    # For some reason the imagesLoaded function is not working so
    # let's kick it OLD SCHOOL
    img = new Image()
    img.onload = =>
      @$piece.closest('.tn-tc-asset-field').trigger('tenon.asset_attached')
    img.src = $img.attr('src')

  _updateFields: =>
    @$piece.find('[data-asset-id-field]').val(@asset.id)
    @$link.data('asset-id', @asset.id)
