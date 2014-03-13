module Tenon
  module AssetHelper
    def asset_icon(asset)
      if asset.attachment.exists?(:thumbnail)
        i = image_tag(asset.attachment.url(:thumbnail))
      else
        i = image_tag('http://placehold.it/500x500')
      end
      link_to(i, [:edit, asset], default_options)
    end

    def default_options
      {
        'data-modal-remote' => true,
        'data-modal-title' => 'Edit Asset'
      }
    end
  end
end