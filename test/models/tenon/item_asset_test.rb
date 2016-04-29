require 'test_helper'

module Tenon
  class ItemAssetTest < ActiveSupport::TestCase
    def setup
      @ia = Tenon::ItemAsset.new
      @asset = stub
      @ia.stubs(:asset).returns(@asset)
      @ia.stubs(:asset_id_changed?).returns(true)
    end


    test '#reprocess_asset reloads the asset' do
      @asset.expects(:reload).returns(@asset)
      @asset.stubs(:attachment).returns(stub_everything)
      @asset.stubs(:reprocess!)
      @ia.reprocess_asset
    end

    test '#reprocess_asset reprocesses the asset' do
      attachment = stub
      @asset.stubs(:reload).returns(@asset)
      @asset.stubs(:attachment).returns(attachment)
      attachment.expects(:reprocess!)
      @ia.reprocess_asset
    end

    test '#reprocess_asset does nothing is asset_id_changed? is false' do
      @ia.stubs(:asset_id_changed?).returns(false)
      @asset.expects(:reload).never
      @ia.reprocess_asset
    end
  end
end
