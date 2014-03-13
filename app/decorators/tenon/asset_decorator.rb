module Tenon
  class AssetDecorator < ApplicationDecorator
    def icon
      h.asset_icon(object)
    end

    def human_size
      h.number_to_human_size(object.attachment_file_size)
    end

    def display_name
      name = object.title.blank? ? object.attachment_file_name : object.title
      h.truncate(name, :length => 50)
    end

    def crop_link
      h.action_link(
        'Crop',
        [:crop, object],
        'crop',
        :class => 'asset-crop',
        :data => {
          'asset-id' => object.id,
          'post-crop-handler' => 'Tenon.features.AssetListPostCropHandler'
        }
      )
    end

    def edit_link(opts = {})
      defaults = {
        'data-modal-remote' => true,
        'data-modal-title' => 'Edit Asset'
      }
      super(opts.merge(defaults))
    end

    def style_urls
      styles = object.attachment.styles.map do |key, style|
        [key, object.attachment.url(key)]
      end
      Hash[styles]
    end
  end
end