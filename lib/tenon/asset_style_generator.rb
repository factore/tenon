module Tenon
  class AssetStyleGenerator
    attr_reader :asset

    def self.generate(asset)
      new(asset).styles
    end

    def initialize(asset)
      @asset = asset
    end

    def styles
      @styles ||= Hash[*item_assets.map do |ia|
        get_styles_from_item(ia) || []
      end.flatten].merge(default_styles)
    end

    private

    def default_styles
      {
        original: { processors: ['cropper'], geometry: '' },
        thumbnail: '100x100#',
        medium: '1400>', # DEPRECATED
        tile: '350x350#',
      }
    end

    def item_assets
      @item_assets ||= asset.item_assets.map do |ia|
        attributes_for(ia)
      end.uniq
    end

    def get_styles_from_item(item_asset)
      item = item_asset[:klass].new
      styles = item.send("#{item_asset[:asset_name]}_styles")
      if styles
        item.send("#{item_asset[:asset_name]}_styles").map do |name, style|
          ["#{item_asset[:prefix]}_#{name}".to_sym, style]
        end.flatten
      end
    end

    def attributes_for(item_asset)
      {
        klass: item_asset.item_type.constantize,
        asset_name: item_asset.asset_name,
        prefix: style_prefix_for(item_asset)
      }
    end

    def style_prefix_for(item_asset)
      class_prefix = item_asset.item_type.underscore.gsub('/', '_')
      "#{class_prefix}_#{item_asset.asset_name}"
    end
  end
end
