Tenon.features.fileSelectWidget = {
  init: function () {
    var self = Tenon.features.fileSelectWidget;
    $(document)
      .on('click', 'a.select-asset',  self.selectAsset)
      .on('click', 'a.upload-file', self.uploadFile)
      .on('click', 'a.attach-to-object', self.attachToObject);
  },

  selectAsset: function (event) {
    event.preventDefault();
    var self = Tenon.features.fileSelectWidget,
        $this = $(this);

    Tenon.assetDrawer.asset_id_container = $this.closest('div').find('.file-widget-asset-id').attr('id')
    Tenon.assetDrawer.asset_url_container = $this.closest('div').find('.file-widget-asset-url').attr('id')
    Tenon.assetDrawer.load(null, '/tenon/assets/drawer?single=true');
  },

  uploadFile: function (event) {
    event.preventDefault();
    var self = Tenon.features.fileSelectWidget,
        $this = $(this);

    Tenon.assetDrawer.asset_id_container = $this.closest('div').find('.file-widget-asset-id').attr('id');
    Tenon.assetDrawer.asset_url_container = $this.closest('div').find('.file-widget-asset-url').attr('id');
    Tenon.features.assets.dialog.showNew('#new-asset-dialog', '/tenon/assets/new?single=true&for_model=true');
  },

  attachToObject: function (event) {
    event.preventDefault();
    var self = Tenon.features.fileSelectWidget,
        $this = $(this);

    var id =  $(this).closest('li').attr('id').replace('asset_', ''),
        url = $(this).closest('li').find('img').attr('src');
    Tenon.assetDrawer.attachToObject(id, url);
  },
};