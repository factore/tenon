class Tenon.features.tenonContent.ImageAssetLink extends Tenon.features.tenonContent.AssetAttachment
  _setFields: ($li) =>
    $input = @$browseButton.closest('div').find('input')
    $input[0].value = $li.data('style-urls')['original']
    Tenon.activeImageControlsLinkForm.saveForm()