class Tenon.features.tenonContent.AssetLink extends Tenon.features.tenonContent.AssetAttachment
  _setFields: ($li) =>
    $link = $('<a />').attr('href', $li.data('style-urls')['original'])
    selected = @$browseButton.getSelection().getSelectedText()
    text = if selected.length then selected else I18n.tenon.assets.asset_link
    $link.html(text)
    @$browseButton.insertHtml($link[0].outerHTML)

  # Create a virtual input to hold the data
  _getAssetField: =>
    $('<input />').attr('type', 'hidden')
