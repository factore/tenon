class Tenon.features.AssetListPostCropHandler
  constructor: (@$link, @asset) ->
    $('.asset-cropping').remove()
    @$list = $('#assets')
    @_drawAsset()

  _drawAsset: =>
    if @$list.find("li[data-record-id=#{@asset.id}]").length > 0
      @$list.find("li[data-record-id=#{@asset.id}]").replaceWith(@_template())
    else
      @$list.prepend(@_template())
    @$list.imagesLoaded => @$list.find('li.hidden').removeClass('hidden')

  _template: =>
    $(JST['tenon/templates/assets/asset_row'](asset: @asset))