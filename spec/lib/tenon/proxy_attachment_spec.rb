require 'spec_helper'

class Item; end

describe Tenon::ProxyAttachment do
  let(:pa) { Tenon::ProxyAttachment.new(attachment, klass, asset_name) }
  let(:asset_name) { 'banner' }
  let(:klass) { Item }

  describe '.new' do
    context 'when instantiating with an Asset' do
      let(:attachment) { double(attachment: 'hello') }
      it "should set the attachment as the Asset's attachment" do
        expect(pa.attachment).to eq('hello')
      end
    end

    context 'when instantiating with an attachment' do
      let(:attachment) { double }
      it 'should set the attachment as the attachment' do
        expect(pa.attachment).to eq(attachment)
      end
    end
  end


  describe '#original_filename' do
    let(:attachment) { double(original_filename: 'filename') }

    it "should get the original filename from the asset attachment" do
      expect(pa.original_filename).to eq('filename')
    end
  end

  describe '#display_name' do
    let(:ad) { double(display_name: 'display') }
    let(:attachment) { double.as_null_object }
    before do
      Tenon::AssetDecorator.stub(:new) { ad }
    end

    it "should get the display name from the original asset" do
      expect(pa.display_name).to eq(ad.display_name)
    end
  end

  describe '#url' do
    let(:attachment) { double }
    context 'with a preceding underscore' do
      it "should get the url from the attachment" do
        expect(attachment).to receive(:url).with('original')
        pa.url(:_original)
      end
    end

    context 'without a preceding underscore' do
      it 'should get the url from the attachment including the prefix' do
        expect(attachment).to receive(:url).with('item_banner_original')
        pa.url(:original)
      end
    end
  end
end
