module Tenon
  module Reorderable
    def self.included(mod)
      mod.extend(ClassMethods)
    end

    module ClassMethods
      def reorder!(list)
        list.each_with_index do |id, order|
          item = self.find_by_id(id)
          item.list_order = order and item.save unless item.blank?
        end
      end
    end
  end
end
