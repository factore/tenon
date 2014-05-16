require 'spec_helper'

describe Tenon::HasHistory::AttrSerializer do
  let(:serializer) { Tenon::HasHistory::AttrSerializer.new(attrs, item_version) }
  let(:item_version) { Tenon::ItemVersion.new(item: item) }
  let(:item) { create(:page) }

  context '#serialize' do
    context 'with basic attrs' do
      let(:attrs) { predefined_attrs[:basic] }

      it 'should clear out the ID' do
        expect(serializer.serialize).to eq(Marshal.dump(title: 'Title'))
      end
    end

    context 'when the attrs have excepted fields' do
      let(:attrs) { predefined_attrs[:with_excepted] }

      it 'should clear out the ID' do
        expect(serializer.serialize).to eq(Marshal.dump(title: 'Title'))
      end
    end

    context 'when the attrs have children that are not included' do
      let(:attrs) { predefined_attrs[:unincluded_children] }

      it 'should clear them out' do
        expect(serializer.serialize).to eq(Marshal.dump(title: 'Title'))
      end
    end

    context 'when the attrs have children that are included' do
      let(:attrs) { predefined_attrs[:included_children] }

      it 'should keep them' do
        expected = Marshal.dump(attrs.deep_reject_key!(:id))
        expect(serializer.serialize).to eq(expected)
      end
    end
  end
end

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
