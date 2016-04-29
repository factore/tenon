require 'test_helper'

connection = ActiveRecord::Base.connection
connection.drop_table :dogs rescue nil
connection.create_table :dogs do |t|
  # Nada
end

class Dog < ActiveRecord::Base
  has_history except: [:lft, :rgt, :depth],
              includes: [:content_tenon_content_rows]
end

module Tenon
  module HasHistory
    class AttrSerializerTest < ActiveSupport::TestCase
      def setup
        @item = Dog.new
      end

      def default_item_version
        ItemVersion.new(item: @item)
      end

      def build(attrs, item_version = nil)
        item_version ||= default_item_version
        AttrSerializer.new(attrs, item_version)
      end

      test '#serialize with basic attrs clears out the id attr' do
        serializer = build(predefined_attrs[:basic])
        assert_equal serializer.serialize, Marshal.dump(title: 'Title')
      end

      test '#serailize with excepted fields clears out the id' do
        serializer = build(predefined_attrs[:with_excepted])
        assert_equal serializer.serialize, Marshal.dump(title: 'Title')
      end

      test '#serialize with unincluded child attrs does not include them' do
        serializer = build(predefined_attrs[:unincluded_children])
        assert_equal serializer.serialize, Marshal.dump(title: 'Title')
      end

      test '#serialize keeps included child attrs' do
        attrs = predefined_attrs[:included_children]
        serializer = build(attrs)
        expected_attrs = Marshal.dump(attrs.to_h.deep_reject_key!(:id))
        assert_equal serializer.serialize, expected_attrs
      end

      private

      def predefined_attrs
        {
          basic: { title: 'Title', id: 14 },
          with_excepted: { title: 'Title', lft: 3, rgt: 5, depth: 6 },
          unincluded_children: {
            title: 'Title',
            fake_children_attributes: {
              first: { test: 'item' },
              second: { test: 'item' }
            }
          },
          included_children: {
            title: 'Title',
            content_tenon_content_rows_attributes: {
              first: { foo: 'bar', id: 1 },
              second: { foo: 'bar', id: 2 }
            }
          }
        }
      end
    end
  end
end
