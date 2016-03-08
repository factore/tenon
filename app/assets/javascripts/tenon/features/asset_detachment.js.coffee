class Tenon.features.AssetDetachment
  constructor: ->
    $(document).on('click', '.remove-asset', @_removeAsset)

  _removeAsset: (e) =>
    e.preventDefault()
    e.stopPropagation()
    @$assetField = $(e.currentTarget).closest('.asset-field')
    @$assetField.find('[data-asset-id-field]').removeAttr('value')
    @$assetField.find('[data-asset-thumbnail] > img')
      .attr('src', '/assets/tenon/thumb-doc.png')
    @$assetField.find('[data-asset-info]').html('No asset selected.')
