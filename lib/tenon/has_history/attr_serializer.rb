module Tenon
  module HasHistory
    class AttrSerializer
      def self.serialize(attrs, item_version)
        new(attrs, item_version).serialize
      end

      def initialize(attrs, item_version)
        @attrs = attrs
        @item_version = item_version
        @item_class = item_version.item_type.constantize
        @item = @item_version.item
      end

      def serialize
        Marshal.dump(filtered_attrs)
      end

      private

      def filtered_attrs
        @attrs.deep_reject_key!(:id)
        @attrs.deep_reject_key!('id')
        require_only_attrs! unless only.empty?
        remove_except_attrs! unless except.empty?
        remove_children!
        @attrs
      end

      def require_only_attrs!
        @attrs = @attrs.select { |k, v| only.include?(k) }
      end

      def remove_except_attrs!
        @attrs = @attrs.reject { |k, v| except.include?(k.to_sym) }
      end

      def remove_children!
        @attrs = @attrs.reject do |k, v|
          key = k.to_s
          relation = key.gsub(/_attributes$/, '')
          key.match(/_attributes$/) && !includes.include?(relation)
        end
      end

      def only
        @item_class.instance_variable_get('@has_history_only')
      end

      def except
        @item_class.instance_variable_get('@has_history_except')
      end

      def includes
        @item_class.instance_variable_get('@has_history_includes').map(&:to_s)
      end
    end
  end
end
