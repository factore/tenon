module Tenon
  module TenonContent
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def tenon_content(content_field, i18n: false)
        Tenon::TenonContentBuilder.add_assoc(self, content_field)

        define_method("#{content_field}_i18n?") { i18n }
        if i18n
          Tenon.config.languages.each do |title, lang|
            Tenon::TenonContentBuilder.add_assoc(self, "#{content_field}_#{lang}")
          end
        end
      end
    end
  end

  class TenonContentBuilder
    class << self
      def add_assoc(klass, content_field)
        assoc = "#{content_field}_tenon_content_rows".to_sym
        args = [assoc, -> { where(item_method: content_field) }, assoc_opts]
        klass.send(:has_many, *args)
        klass.send(:accepts_nested_attributes_for, assoc, allow_destroy: true)
      end

      private

      def assoc_opts
        {
          class_name: 'Tenon::TenonContent::Row',
          as: :item,
          dependent: :destroy
        }
      end
    end
  end
end

ActiveRecord::Base.send(:include, Tenon::TenonContent)
