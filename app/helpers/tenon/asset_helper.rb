module Tenon
  module AssetHelper
    def asset_icon(asset)
      if asset.attachment.exists?(:thumbnail)
        image = image_tag(asset.attachment.url(:thumbnail))
      else
        image = image_tag(default_asset_thumbnail(asset))
      end
      asset_icon_link(asset, image)
    end

    def asset_icon_link(asset, icon)
      if asset.is_image?
        link_to(icon, [:crop, asset], crop_options(asset))
      else
        link_to(icon, asset.attachment.url, target: '_')
      end
    end

    def asset_tile(asset)
      if asset.attachment.exists?(:tile)
        image = image_tag(asset.attachment.url(:tile))
      else
        image = image_tag(default_asset_thumbnail(asset))
      end
      asset_tile_link(asset, image)
    end

    def asset_tile_link(asset, icon)
      if asset.is_image?
        link_to(icon, [:crop, asset], crop_options(asset))
      else
        link_to(icon, asset.attachment.url, target: '_')
      end
    end

    def default_asset_thumbnail(asset)
      if asset && asset.attachment_content_type.match('video')
        'tenon/thumb-video.png'
      else
        'tenon/thumb-doc.png'
      end
    end

    def responsive_image_tag(asset, size, options = {})
      srcset = generate_srcset(asset)
      sizes = generate_sizes(size)
      image_tag(asset.attachment.url(:x2000), options.merge(srcset: srcset, sizes: sizes))
    end

    private
      def generate_sizes(size)
        "(min-width: 768px) #{size}vw, 100vw"
      end

      def generate_srcset(asset)
        (1..10).map do |n|
          "#{asset.attachment.url("x#{n*200}".to_sym)} #{(n*200).to_s}w"
        end.join(', ')
      end

      def crop_options(asset)
        {
          class: 'asset-crop',
          data: {
            'asset-id' => asset.id,
            'post-crop-handler' => 'Tenon.features.AssetListPostCropHandler'
          }
        }
      end

      def default_options
        {
          'data-modal-remote' => true,
          'data-modal-title' => 'Edit Asset'
        }
      end
    end
end
