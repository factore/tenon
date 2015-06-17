class Tenon.features.AssetAttachment
  constructor: (@$browseButton, @$container) ->
    @$assetField = @_getAssetField()
    @_setupAssetList()
    @_setupAssetUploading()

  _setupAssetList: =>
    @$list = @$container.find('ul.asset-list')
    new Tenon.features.RecordList(@$list)
    @$list.on('click', 'li.asset a', @_pickAsset)

  _setupAssetUploading: =>
    @uploader = new Tenon.features.AssetUploader(@_uploadComplete)
    @uploader.initialize('#new_asset')

  _pickAsset: (e) =>
    e.preventDefault()
    e.stopPropagation()
    $li = $(e.currentTarget).closest('li.asset')
    @_setFields($li)
    @$container.closest('.modal').modal('hide')

  _uploadComplete: (e, data) =>
    li = JST["tenon/templates/assets/asset_row"](asset : data.result)
    @_setFields($(li))
    @$container.closest('.modal').modal('hide')

  _setFields: ($li) =>
    @$assetField.find('.asset-id-field').val($li.data('record-id'))
    @$assetField.find('.thumbnail').html($li.find('.thumbnail').html())
    @$assetField.find('.asset-info').html($li.find('.record-title a').html())

  _getAssetField: =>
    if @$browseButton.data('asset-field')
      $(@$browseButton.data('asset-field'))
    else
      @$browseButton.closest('.tn-tc-asset-field')
