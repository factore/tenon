module Tenon
  module TenonContent
    def self.included(mod)
      mod.extend(ClassMethods)
    end

    module ClassMethods
      def tenon_content(content_field)
        assoc = "#{content_field}_tenon_content_rows".to_sym
        has_many assoc,
                 -> { where(item_method: content_field) },
                 class_name: 'Tenon::TenonContent::Row',
                 as: :item,
                 dependent: :destroy
        accepts_nested_attributes_for assoc, allow_destroy: true
      end
    end
  end
end

ActiveRecord::Base.send(:include, Tenon::TenonContent)
