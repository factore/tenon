require 'spec_helper'

describe Tenon::Page do
  let(:page) { Tenon::Page.new }

  describe '#subpages_for_menu' do
    context 'a page with no subpages' do
      before do
        page.stub(:subpages) { nil }
      end

      it 'should find siblings for the menu' do
        expect(page).to receive(:siblings_for_menu)
        page.subpages_for_menu
      end
    end

    context 'a page with subpages' do
      let(:subpages) { double }

      before do
        page.stub(:subpages) { subpages }
      end

      it 'should grab the subpages that are available for the menu' do
        args = { published: true, show_in_menu: true }
        expect(subpages).to receive(:where).with(args)
        page.subpages_for_menu
      end
    end
  end

  describe '#siblings_for_menu' do
    context 'when the page has no parent' do
      before do
        page.stub(:parent) { nil }
      end

      it 'should return nil' do
        expect(page.siblings_for_menu).to be_nil
      end
    end

    context 'when the page has a parent' do
      let(:parent) { double }

      before do
        page.stub(:parent) { parent }
      end

      it "should find the parent's subpages" do
        expect(parent).to receive(:subpages_for_menu)
        page.siblings_for_menu
      end
    end
  end

  describe '.reorder' do
    it 'TODO: Figure out how this works so we can test it.'
  end
end
