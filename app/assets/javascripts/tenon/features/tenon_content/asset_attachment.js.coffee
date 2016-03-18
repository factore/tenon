class Tenon.features.tenonContent.AssetAttachment extends Tenon.features.AssetAttachment
  _setFields: (e, data) =>
    @$assetField.find('.asset-id-field').val(data.id)
    @$assetField.find('.asset-crop').attr('data-asset-id', data.id)
    $img = $("<img />").attr('src', data.mediumPath)
    @$assetField.find('.image a.add-image, .image img').remove()
    @$assetField.find('.image').prepend($img)

    # We have to make sure the image loads before we fire the trigger
    # For some reason the imagesLoaded function is not working so
    # let's kick it OLD SCHOOL
    img = new Image()
    img.onload = => @$assetField.trigger('tenon.asset_attached')
    img.src = $img.attr('src')

    Tenon.features.ModalWindows.closeModals()

