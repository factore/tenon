require 'test_helper'

module Tenon
  module TenonContent
    class RowDecoratorTest < ActiveSupport::TestCase
      def setup
        row_type_class = stub(
          partial: 'partial',
          form_partial: 'form_partial'
        )
        row_type = stub(row_type_class: row_type_class)
        @decorator = RowDecorator.new(row_type)
      end

      test '#partial gets the partial from the row_type_class' do
        assert_equal @decorator.partial, 'partial'
      end

      test '#form_partial gets the partial from the row_type_class' do
        assert_equal @decorator.form_partial, 'form_partial'
      end
    end
  end
end
