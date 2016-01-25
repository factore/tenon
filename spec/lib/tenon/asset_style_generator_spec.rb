require 'spec_helper'

describe Tenon::AssetStyleGenerator do
  let(:asg) { Tenon::AssetStyleGenerator.new(asset) }

  describe '#styles' do
    context 'with a Page that has a banner with a :thumbnail style and a :medium style' do
      let(:asset) do
        double(
          item_assets: item_assets
        )
      end

      let(:page) do
        double(banner_styles: { medium: '800x800>', thumbnail: '300x300#' })
      end

      let(:item_assets) do
        [double(item: page, asset_name: 'banner', item_type: 'Page')]
      end

      before do
        Page.stub(:new) { page }
      end

      it 'should return a combination of the default styles and the banner styles' do
        expect(asg.styles).to eq asg.send(:default_styles).merge(
          tenon_page_banner_medium: '800x800>',
          tenon_page_banner_thumbnail: '300x300#'
        )
      end

      context 'with post with a header with a :wide style as well' do
        let(:post) do
          double(header_styles: { wide: '800x300#' })
        end

        let(:item_assets) do
          [
            double(item: page, asset_name: 'banner', item_type: 'Page'),
            double(item: post, asset_name: 'header', item_type: 'Post')
          ]
        end

        before do
          Post.stub(:new) { post }
        end

        it 'should return a combination of the default styles, the page banner styles, and the post header styles' do
          expect(asg.styles).to eq asg.send(:default_styles).merge(
            tenon_page_banner_medium: '800x800>',
            tenon_page_banner_thumbnail: '300x300#',
            tenon_post_header_wide: '800x300#'
          )
        end
      end

      context 'with a second page' do
        let(:other_page) do
          double(banner_styles: { medium: '800x800>', thumbnail: '300x300#' })
        end

        let(:item_assets) do
          [
            double(item: page, asset_name: 'banner', item_type: 'Page'),
            double(item: other_page, asset_name: 'banner', item_type: 'Page')
          ]
        end

        before do
          Page.stub(:new) { page }
        end

        it 'should return a combination of the default styles and the banner styles without duplicating' do
          expect(asg.styles).to eq asg.send(:default_styles).merge(
            tenon_page_banner_medium: '800x800>',
            tenon_page_banner_thumbnail: '300x300#'
          )
        end
      end
    end

  end
end
