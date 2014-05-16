require 'spec_helper'

describe Tenon::ItemAsset do
  describe '#reprocess_asset' do
    let(:ia) { Tenon::ItemAsset.new }
    let(:asset) { double }
    before do
      Tenon::ItemAsset.any_instance.stub(:asset) { asset }
    end

    it 'should reload the asset and reprocess the attachment' do
      Tenon::ItemAsset.any_instance.stub(:asset_id_changed?) { true }
      expect(asset).to receive(:reload) { asset }
      expect(asset).to receive(:attachment) { asset }
      expect(asset).to receive(:reprocess!)
      ia.reprocess_asset
    end
  end
end
