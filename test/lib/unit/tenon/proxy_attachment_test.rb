require 'test_helper'

class Item; end

module Tenon
  class Item; end

  class ProxyAttachmentTest < ActiveSupport::TestCase
    def build_pa(attachment, klass = ::Item, name = 'banner')
      ProxyAttachment.new(attachment, klass, name)
    end

    test ".new when instantiating with an asset uses the asset's attachment" do
      pa = build_pa(stub(attachment: 'hello'))
      assert_equal pa.attachment, 'hello'
    end

    test '.new when instantiating with an attachment uses the attachment' do
      attachment = stub
      pa = build_pa(attachment)
      assert_equal pa.attachment, attachment
    end

    test '#original_filename delegates to the attachment' do
      attachment = stub(original_filename: 'filename')
      pa = build_pa(attachment)
      assert_equal pa.original_filename, 'filename'
    end

    test '#display_name delegates to the original asset' do
      ad = stub(display_name: 'display')
      attachment = stub_everything
      AssetDecorator.stubs(:new).returns(ad)
      pa = build_pa(attachment)
      assert_equal pa.display_name, ad.display_name
    end

    test '#url with a leading underscore delegates to the attachment' do
      attachment = stub(styles: nil)
      pa = build_pa(attachment)
      attachment.expects(:url).with('original')
      pa.url(:_original)
    end

    test '#url without a leading underscore delegates with a prefix' do
      attachment = stub(styles: nil)
      pa = build_pa(attachment)
      attachment.expects(:url).with('item_banner_medium')
      pa.url(:medium)
    end

    test '#url without a leading underscore and a namespaced model delegates
          properly with a prefix' do
      attachment = stub(styles: nil)
      pa = build_pa(attachment, Tenon::Item)
      attachment.expects(:url).with('tenon_item_banner_medium')
      pa.url(:medium)
    end

    test '#url when getting original and an original style is set on the model
          gets the url from the attachment with the correct prefix' do
      attachment = stub(styles: { item_banner_original: 'foo' })
      pa = build_pa(attachment)
      attachment.expects(:url).with(:item_banner_original)
      pa.url(:original)
    end

    test '#url when getting original and no original style is set on the model
          gets the url from the attachment with no prefix' do
      attachment = stub(styles: {})
      pa = build_pa(attachment)
      attachment.expects(:url).with(:original)
      pa.url(:original)
    end
  end
end
