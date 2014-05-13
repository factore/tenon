module Tenon
  module HasAsset
    def self.included(mod)
      mod.extend(ClassMethods)
    end

    module ClassMethods
      def has_asset(asset_name, opts = {})
        build_join(asset_name)
        build_getters(asset_name)
        build_setters(asset_name)
        build_style_hash(asset_name, opts[:styles])
      end

      private

      def build_join(asset_name)
        send(
          :has_one,
          "#{asset_name}_join".to_sym,
          -> { where(asset_name: asset_name) },
          class_name: 'Tenon::ItemAsset',
          as: :item,
          dependent: :destroy
        )
      end

      def build_getters(asset_name)
        build_asset_getter(asset_name)
        build_asset_id_getter(asset_name)
      end

      def build_asset_getter(asset_name)
        define_method(asset_name) do
          if instance_variable_get("@#{asset_name}")
            instance_variable_get("@#{asset_name}")
          else
            relation = Tenon::ItemAsset.where(item_type: self.class.to_s, item_id: id, asset_name: asset_name)
            asset = relation.first.try(:asset).try(:attachment)
            if asset
              attach = ProxyAttachment.new(asset, self.class, asset_name)
            else
              attach = nil
            end
            instance_variable_set("@#{asset_name}", attach)
          end
        end
      end

      def build_asset_id_getter(asset_name)
        define_method("#{asset_name}_id") do
          if instance_variable_get("@#{asset_name}_id")
            instance_variable_get("@#{asset_name}_id")
          else
            relation = Tenon::ItemAsset.where(item_type: self.class.to_s, item_id: id, asset_name: asset_name)
            relation.first.try(:asset_id)
          end
        end
      end

      def build_setters(asset_name)
        build_asset_setter(asset_name)
        build_asset_id_setter(asset_name)
      end

      def build_asset_setter(asset_name)
        define_method("#{asset_name}=") do |val|
          attrs = { asset_attributes: { attachment: val } }
          join = send("#{asset_name}_join") || send("build_#{asset_name}_join")
          join.assign_attributes(attrs)
          join.save
          asset = join.asset
          asset.item_assets << join
          attach = ProxyAttachment.new(asset, self.class, asset_name)
          instance_variable_set("@#{asset_name}", attach)
        end
      end

      def build_asset_id_setter(asset_name)
        define_method("#{asset_name}_id=") do |val|
          unless val.blank?
            asset = Tenon::Asset.find(val)
            attrs = { asset_id: val }
            join = send("#{asset_name}_join") || send("build_#{asset_name}_join")
            join.assign_attributes(attrs)
            join.save
            attachment = ProxyAttachment.new(asset.attachment, self.class, asset_name)
            instance_variable_set("@#{asset_name}_id", val)
            instance_variable_set("@#{asset_name}", attachment)
          end
        end
      end

      def build_style_hash(asset_name, styles)
        define_method("#{asset_name}_styles") do
          styles
        end
      end
    end
  end
end

ActiveRecord::Base.send(:include, Tenon::HasAsset)
