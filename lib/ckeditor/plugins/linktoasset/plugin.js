CKEDITOR.plugins.add( 'linktoasset', {
  icons: 'linktoasset',
  init: function( editor ) {
    editor.addCommand( 'linkToAsset', {
      exec: function( editor ) {
        opts = {
          $link: editor,
          handler: 'Tenon.features.tenonContent.AssetLink',
          href: '/tenon/item_assets/new?hide_upload=true',
          title: 'Link to an Asset',
          remote: 'True'
        }
        Tenon.modals.launchWithOpts(opts)
        // editor.insertHtml( 'The current date and time is: <em>' + now.toString() + '</em>' );
      }
    });

    editor.ui.addButton( 'LinkToAsset', {
      label: 'Link to an Asset',
      command: 'linkToAsset',
      toolbar: 'links,10'
    });
  }
});
