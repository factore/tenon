require 'test_helper'

module Tenon
  class AssetDecoratorTest < ActiveSupport::TestCase
    def build(asset = stub_everything)
      AssetDecorator.new(asset)
    end

    test '#icon uses the helper icon' do
      asset = stub_everything
      ad = build(asset)
      ad.h.expects(:asset_icon).with(asset)
      ad.icon
    end

    test '#human_size gets the human size of the attachment' do
      ad = build(stub(attachment_file_size: 1024))
      ad.h.expects(:number_to_human_size).with(1024)
      ad.human_size
    end

    test '#display_name uses the title when present' do
      ad = build(stub(title: 'My Title'))
      assert_equal ad.display_name, 'My Title'
    end

    test '#display_name uses the file name when title is not present' do
      ad = build(stub(attachment_file_name: 'nsync.mp3.exe', title: nil))
      assert_equal ad.display_name, 'nsync.mp3.exe'
    end

    test '#style_urls returns a hash of the styles' do
      styles = { banner: '100x100', thumbnail: '50x50' }
      ad = build(stub(attachment: stub(styles: styles, url: '/images/1.jpg')))
      expectation = { banner: '/images/1.jpg', thumbnail: '/images/1.jpg' }
      assert_equal ad.style_urls, expectation
    end
  end
end
