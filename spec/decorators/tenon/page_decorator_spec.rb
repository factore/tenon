require 'spec_helper'

describe Tenon::PageDecorator do
  let(:pd) { Tenon::PageDecorator.new(page) }
  describe '#option_title' do
    context 'when a page has a depth of 0' do
      let(:page) { double(depth: 0, title: 'title') }

      it "should return the page's title" do
        expect(pd.option_title).to eq(page.title)
      end
    end

    context 'when a page has a depth of 1' do
      let(:page) { double(depth: 1, title: 'title') }

      it "should return some nesting and the page's title" do
        expected = "&nbsp;&nbsp;&nbsp;- #{page.title}"
        expect(pd.option_title).to eq(expected)
      end
    end
  end
end
