require 'test_helper'

class TestObj
end

class OtherTestObj
end

module Tenon
  class AssetStyleGeneratorTest < ActiveSupport::TestCase
    def obj
      stub(banner_styles: { medium: '800x800>', thumbnail: '300x300#' })
    end

    def other_obj
      stub(header_styles: { wide: '800x300#' })
    end

    def asset(item_assets)
      stub(item_assets: item_assets)
    end

    test '#styles with a TestObject returns the styles' do
      TestObj.stubs(:new).returns(obj)
      item_assets = [
        stub(item: obj, asset_name: 'banner', item_type: 'TestObj')
      ]
      asg = Tenon::AssetStyleGenerator.new(asset(item_assets))
      expected_styles = asg.send(:default_styles).merge(
        test_obj_banner_medium: '800x800>',
        test_obj_banner_thumbnail: '300x300#'
      )
      assert_equal asg.styles, expected_styles
    end

    test '#styles with a TestObj and an OtherTestObj returns the styles' do
      TestObj.stubs(:new).returns(obj)
      OtherTestObj.stubs(:new).returns(other_obj)
      item_assets = [
        stub(item: obj, asset_name: 'banner', item_type: 'TestObj'),
        stub(item: other_obj, asset_name: 'header', item_type: 'OtherTestObj')
      ]
      asg = Tenon::AssetStyleGenerator.new(asset(item_assets))
      expected_styles = asg.send(:default_styles).merge(
        test_obj_banner_medium: '800x800>',
        test_obj_banner_thumbnail: '300x300#',
        other_test_obj_header_wide: '800x300#'
      )
      assert_equal asg.styles, expected_styles
    end

    test '#styles with two TestObjs returns the styles without duplication' do
      TestObj.stubs(:new).returns(obj)
      second_obj = obj.dup
      item_assets = [
        stub(item: obj, asset_name: 'banner', item_type: 'TestObj'),
        stub(item: second_obj, asset_name: 'banner', item_type: 'TestObj')
      ]
      asg = Tenon::AssetStyleGenerator.new(asset(item_assets))
      expected_styles = asg.send(:default_styles).merge(
        test_obj_banner_medium: '800x800>',
        test_obj_banner_thumbnail: '300x300#'
      )
      assert_equal asg.styles, expected_styles
    end
  end
end
