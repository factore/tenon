class Tenon.features.tenonContent.AssetAttachment extends Tenon.features.AssetAttachment
  _setFields: ($li) =>
    @$assetField.find('.asset-id-field').val($li.data('record-id'))
    @$assetField.find('.asset-crop').attr('data-asset-id', $li.data('record-id'))
    $img = $li.find('.thumbnail img').clone()
    $img.attr('src', $li.data('style-urls')['medium'])
    @$assetField.find('.image a.add-image, .image img').remove()
    @$assetField.find('.image').prepend($img)

    # We have to make sure the image loads before we fire the trigger
    # For some reason the imagesLoaded function is not working so
    # let's kick it OLD SCHOOL
    img = new Image()
    img.onload = => @$assetField.trigger('tenon.asset_attached')
    img.src = $img.attr('src')
