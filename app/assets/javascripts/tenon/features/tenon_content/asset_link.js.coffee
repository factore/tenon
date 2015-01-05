class Tenon.features.tenonContent.AssetLink extends Tenon.features.tenonContent.AssetAttachment
  _setFields: ($li) =>
    console.log @$browseButton
    console.log '-1-1-1-1-1-1-'

    $input = @$browseButton.closest('div').find('input')
    $input[0].value = $li.data('style-urls')['original']
    Tenon.mediumEditor.createLink($input[0])