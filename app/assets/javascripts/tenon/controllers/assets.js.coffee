Tenon.dispatcher.route 'tenon/assets#index', ->
  assetUploader = new Tenon.features.AssetUploader
  assetUploader.initialize('#new_asset')