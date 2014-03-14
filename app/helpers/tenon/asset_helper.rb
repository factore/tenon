module Tenon
  module AssetHelper
    def asset_icon(asset)
      if asset.attachment.exists?(:thumbnail)
        i = image_tag(asset.attachment.url(:thumbnail))
      else
        i = image_tag(default_asset_thumbnail(asset))
      end
      link_to(i, [:edit, asset], default_options)
    end

    def default_asset_thumbnail(asset)
      if asset && asset.attachment_content_type.match('video')
        'tenon/thumb-video.png'
      else
        'tenon/thumb-doc.png'
      end
    end

    private

    def default_options
      {
        'data-modal-remote' => true,
        'data-modal-title' => 'Edit Asset'
      }
    end
  end
end