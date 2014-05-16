require 'spec_helper'

describe Tenon::HasHistory do
  let(:page) { create(:page) }

  context 'saving a version' do
    it 'should not save the excepted attributes' do
      iv = Tenon::ItemVersion.create(item: page)
      excepts = page.class.instance_variable_get('@has_history_except')
      excepts.each do |except|
        expect(iv.hashed_item.symbolize_keys.keys).not_to include(except.to_sym)
      end
    end
  end

  context 'restoring a version' do
    it 'should change the attributes back to the restored version' do
      orig_title = page.title
      version = page.versions.create
      page.title = 'new title'
      page.revert(version)
      expect(page.title).to eq(orig_title)
    end
  end
end
