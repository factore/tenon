class Tenon.features.tenonContent.ImageAssetLink extends Tenon.features.tenonContent.AssetAttachment
  _setFields: (e, data) =>
    $input = @$browseButton.closest('div').find('input')
    $input[0].value = data.originalPath
    Tenon.activeImageControlsLinkForm.saveForm()
    Tenon.features.ModalWindows.closeModals()
