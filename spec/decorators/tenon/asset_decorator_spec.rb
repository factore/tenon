require 'spec_helper'

describe Tenon::AssetDecorator do
  let(:ad) { Tenon::AssetDecorator.new(asset) }
  let(:asset) { double.as_null_object }

  describe '#icon' do
    it 'should use the helper icon' do
      expect(ad.h).to receive(:asset_icon).with(asset)
      ad.icon
    end
  end

  describe '#human_size' do
    before do
      asset.stub(:attachment_file_size) { 1024 }
    end

    it 'should get the human size of the attachment' do
      expect(ad.h).to receive(:number_to_human_size).with(1024)
      ad.human_size
    end
  end

  describe '#display_name' do
    context 'when the asset has a title' do
      before do
        asset.stub(:title) { 'My Title' }
      end

      it 'should use the title' do
        expect(ad.display_name).to eq 'My Title'
      end
    end

    context 'when the asset has no title' do
      before do
        asset.stub(:attachment_file_name) { 'nsync.mp3.exe' }
      end

      it 'should use the filename' do
        expect(ad.display_name).to eq 'nsync.mp3.exe'
      end
    end
  end

  describe '#crop_link' do
    it 'should create an action_link' do
      args = [
        'Crop',
        [:crop, asset],
        'crop',
        {
          class: 'asset-crop',
          data: {
            'asset-id' => asset.id,
            'post-crop-handler' => 'Tenon.features.AssetListPostCropHandler'
          }
        }
      ]
      expect(ad.h).to receive(:action_link).with(*args)
      ad.crop_link
    end
  end

  describe '#download_link' do
    before do
      asset.stub(:attachment) { double(url: 'download_url') }
    end

    it 'should create an action_link' do
      args = ['Download', 'download_url', 'download', { target: '_' }]
      expect(ad.h).to receive(:action_link).with(*args)
      ad.download_link
    end
  end

  describe '#edit_link' do
    it 'should send the default options' do
      defaults = {
        'data-modal-remote' => true,
        'data-modal-title' => 'Edit Asset'
      }
      expect(ad.h).to receive(:edit_link).with(asset, defaults)
      ad.edit_link
    end
  end

  describe '#style_urls' do
    let(:attachment) { double(styles: styles, url: '/images/1.jpg') }
    let(:styles) { { banner: '100x100', thumbnail: '50x50' } }
    before do
      asset.stub(:attachment) { attachment }
    end

    it 'should return a hash of the styles' do
      expectation = { banner: '/images/1.jpg', thumbnail: '/images/1.jpg' }
      expect(ad.style_urls).to eq(expectation)
    end
  end
end
