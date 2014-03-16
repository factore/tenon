module Tenon
  module CanBeForeign
    def self.included(mod)
      mod.extend(ClassMethods)
    end

    module ClassMethods
      def foreign_fields
        Tenon::I18nFields[to_s.downcase.to_sym]
      end
    end
  end
end

ActiveRecord::Base.send(:include, Tenon::CanBeForeign)
