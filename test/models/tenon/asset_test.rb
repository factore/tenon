require 'test_helper'

module Tenon
  class AssetTest < ActiveSupport::TestCase
    test '.with_type of "images" should send correct args' do
      args = ['attachment_content_type LIKE ?', "%image%"]
      Tenon::Asset.expects(:where).with(*args)
      Tenon::Asset.with_type('images')
    end

    test '.with_type of "documents" should fall back on .documents' do
      Tenon::Asset.expects(:documents)
      Tenon::Asset.with_type('documents')
    end

    def asset(content_type)
      Tenon::Asset.new(attachment_content_type: content_type)
    end

    test '#is_image? when the asset is an image returns true' do
      assert asset('image/jpeg').is_image?
    end

    test '#is_image? when the asset is not image returns false' do
      refute asset('application/pdf').is_image?
    end

    class DimensionsTest < AssetTest
      def setup
        @asset = Tenon::Asset.new
        @asset.stubs(:attachment).returns(stub(styles: { thumbnail: 'foo' }))
      end

      test '#dimensions uses the Paperclip.io_adapters.for chain to get a file
            from the attachment when the style is :original' do
        Paperclip::Geometry = stub_everything
        io = stub
        Paperclip.stubs(:io_adapters).returns(io)
        io.expects(:for).with(@asset.attachment)
        @asset.dimensions
      end

      test '#dimensions uses Paperclip::Geometry to get the dimensions
            when the style is original' do
        Paperclip.stubs(:io_adapters).returns(stub_everything)
        Paperclip::Geometry = stub_everything
        Paperclip::Geometry.expects(:from_file)
        @asset.dimensions
      end

      test '#dimensions uses the Paperclip.io_adapaters.for chain to get a file
            from the style when the style is not :original' do
        Paperclip::Geometry = stub_everything
        io = stub
        Paperclip.stubs(:io_adapters).returns(io)
        io.expects(:for).with(@asset.attachment.styles[:thumbnail])
        @asset.dimensions(:thumbnail)
      end

      test '#dimensions uses Paperclip::Geometry to get the dimensions
            when the style is not :original' do
        Paperclip.stubs(:io_adapters).returns(stub_everything)
        Paperclip::Geometry = stub_everything
        Paperclip::Geometry.expects(:from_file)
        @asset.dimensions(:thumbnail)
      end
    end

    class CroppingTest < AssetTest
      def setup
        @asset = Tenon::Asset.new
      end

      test '#cropping returns true when #crop_x is present' do
        @asset.stubs(:crop_x).returns(true)
        assert @asset.cropping?
      end

      test '#cropping returns false when #crop_x is not present' do
        refute @asset.cropping?
      end
    end
  end
end
