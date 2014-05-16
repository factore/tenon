require 'tenon/has_history/attr_serializer.rb'
require 'tenon/has_history/item_reverter.rb'

module Tenon
  module HasHistory
    def self.included(mod)
      mod.extend(ClassMethods)
      mod.include(InstanceMethods)
    end

    module ClassMethods
      def has_history(except: [], only: [], includes: [])
        send(:has_many, :versions, class_name: 'Tenon::ItemVersion', as: :item)
        default_except = [:id]
        @has_history_except = (except + default_except).uniq
        @has_history_only = only
        @has_history_includes = includes
      end
    end

    module InstanceMethods
      def has_history_except
        self.class.instance_variable_get('@has_history_except')
      end

      def has_history_only
        self.class.instance_variable_get('@has_history_only')
      end

      def has_history_includes
        self.class.instance_variable_get('@has_history_includes')
      end

      def revert(item_version)
        Tenon::HasHistory::ItemReverter.revert(self, item_version)
      end
    end
  end
end

ActiveRecord::Base.send(:include, Tenon::HasHistory)
