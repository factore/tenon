module Tenon
  module TenonContent
    class RowDecorator < ApplicationDecorator
      def partial
        @object.row_type_class.partial
      end

      def form_partial
        @object.row_type_class.form_partial
      end
    end
  end
end
