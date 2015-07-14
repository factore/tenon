class Tenon.features.MultipleAssetAttachment extends Tenon.features.AssetAttachment
  _uploadComplete: (e, data) ->
    @_addAssociation()
    super

  _addAssociation: ->
    $('.add_fields').click()
    @$assetField = $('.nested-fields .tn-tc-asset-field:last')
