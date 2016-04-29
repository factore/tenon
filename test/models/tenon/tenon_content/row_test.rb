require 'test_helper'

module Tenon
  module TenonContent
    class RowTest < ActiveSupport::TestCase
      def setup
        @row = Row.new
      end

      test '#set_row_type sets the row type' do
        @row.stubs(:build_pieces)
        @row.expects(:row_type=).with('TestType')
        @row.set_row_type('TestType')
      end

      test '#set_row_type builds the pieces' do
        row_type_class = stub
        @row.stubs(:row_type=)
        @row.stubs(:row_type_class).returns(row_type_class)
        row_type_class.expects(:add_pieces_to).with(@row)
        @row.set_row_type('TestType')
      end

      test '#row_type_class returns a constant' do
        RowTypes::TestType = stub
        @row.row_type = 'TestType'
        assert_equal @row.row_type_class, RowTypes::TestType
      end
    end
  end
end
