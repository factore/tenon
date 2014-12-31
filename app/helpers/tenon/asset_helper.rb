module Tenon
  module AssetHelper
    def asset_icon(asset)
      if asset.attachment.exists?(:thumbnail)
        image = responsive_image_tag(asset, :thumbnail)
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
        image = responsive_image_tag(asset, :tile)
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

    def responsive_image_tag(asset, style)
      image_src_set_tag(asset.attachment.url(style), responsive_styles_for(asset, style))
    end

    def front_end_responsive_image_tag(asset, style)
      default_src = "#{asset.style_prefix}_#{style}"
      image_src_set_tag(asset.attachment.url(default_src), front_end_responsive_styles_for(asset, style))
    end

    private
      def front_end_responsive_styles_for(asset, base_style)
        responsive_styles = {}
        Tenon.config.front_end[:breakpoints].each do |name, width|
          computed_style = "#{asset.style_prefix}_#{base_style}_#{name}"
          if asset.attachment.exists?(computed_style.to_sym)
            url = asset.attachment.url(computed_style.to_sym)
            responsive_styles[url] = "#{width}w"
          end
        end
        responsive_styles
      end

      def responsive_styles_for(asset, base_style)
        responsive_styles = {}
        Tenon.config.front_end[:breakpoints].each do |name, width|
          computed_style = "#{base_style}_#{name}"
          if asset.attachment.exists?(computed_style.to_sym)
            url = asset.attachment.url(computed_style.to_sym)
            responsive_styles[url] = "#{width}w"
          end
        end
        responsive_styles
      end

      def image_src_set_tag(source, srcset = {}, options = {})
        srcset = srcset.map { |src, size| "#{src} #{size}" }.join(', ')
        image_tag(source, options.merge(srcset: srcset))
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
