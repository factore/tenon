class Tenon.features.AssetAttachment
  constructor: (@$browseButton, @$container) ->
    @$assetField = @_getAssetField()
    @_setupAssetUploading()
    @$container.on('assetPicked', @_setFields)
    ReactRailsUJS.mountComponents('#pick-asset')

  _setupAssetUploading: =>
    @uploader = new Tenon.features.AssetUploader(@_uploadComplete)
    @uploader.initialize('#new_asset')

  _uploadComplete: (e, data) =>
    @_setFields(e, {
      id: data.result.id,
      thumbnailPath: data.result.style_urls.thumbnail,
      filename: data.result.display_name
    })
    Tenon.features.ModalWindows.closeModals()

  _setFields: (e, data) =>
    @$assetField.find('[data-asset-id-field]').val(data.id)
    @$assetField.find('[data-asset-thumbnail]')
      .html("<img src='#{data.thumbnailPath}' />")
    @$assetField.find('[data-asset-info]').html(data.filename)
    Tenon.features.ModalWindows.closeModals()

  _getAssetField: =>
    if @$browseButton.data('asset-field')
      $(@$browseButton.data('asset-field'))
    else
      @$browseButton.closest('.asset-field')
