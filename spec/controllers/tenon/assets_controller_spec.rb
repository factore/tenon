require 'spec_helper'

describe Tenon::AssetsController do
  routes { Tenon::Engine.routes }

  let(:asset) { double.as_null_object }

  let(:user) do
    double(
      staff?: true,
      super_admin?: false,
      admin?: true
    )
  end

  before do
    controller.stub(:current_user) { user }
    controller.stub(:polymorphic_index_path) { '/tenon/asset-library' }
  end

  describe 'GET index.html' do
    it 'should render the index template' do
      get :index, format: 'html'
      expect(response).to render_template('index')
    end
  end

  describe 'GET index.json' do
    before do
      [:all, :where, :with_type, :paginate].each do |query|
        Tenon::Asset.stub(query) { Tenon::Asset }
      end
    end

    context 'without params[:q] and without params[:type]' do
      it 'should find, paginate, and decorate the Assets' do
        expect(Tenon::Asset).to receive(:all) { Tenon::Asset }
        expect(Tenon::Asset).to receive(:paginate) { Tenon::Asset }
        expect(Tenon::PaginatingDecorator).to receive(:decorate).with(Tenon::Asset)
        get :index, format: 'json'
      end

      it "shouldn't search or sort the assets by type" do
        expect(Tenon::Asset).not_to receive(:where)
        expect(Tenon::Asset).not_to receive(:with_type)
        get :index, format: 'json'
      end
    end

    context 'with params[:q] = "search"' do
      it 'should search the assets with the query' do
        args = [
          'attachment_file_name ILIKE :q OR title ILIKE :q',
          { q: '%search%' }
        ]
        expect(Tenon::Asset).to receive(:where).with(args)
        get :index, format: 'json', q: 'search'
      end

      it 'should not sort the assets by type' do
        expect(Tenon::Asset).not_to receive(:with_type)
        get :index, format: 'json', q: 'search'
      end
    end

    context 'with params[:type] = "images"' do
      it 'should search the assets with the type' do
        expect(Tenon::Asset).to receive(:with_type).with('images')
        get :index, format: 'json', type: 'images'
      end

      it 'should not search the assets by type' do
        expect(Tenon::Asset).not_to receive(:where)
        get :index, format: 'json', type: 'images'
      end
    end

    context 'with params[:q] = "search" and params[:type] = "images"' do
      it 'should search the assets and sort them by type' do
        args = [
          'attachment_file_name ILIKE :q OR title ILIKE :q',
          { q: '%search%' }
        ]
        expect(Tenon::Asset).to receive(:where).with(args)
        expect(Tenon::Asset).to receive(:with_type).with('images')
        get :index, format: 'json', type: 'images', q: 'search'
      end
    end
  end

  describe 'GET edit' do
    before do
      Tenon::Asset.stub(:find)
    end

    it 'should not render the layout' do
      get :edit, id: 1
      expect(response).to render_template(layout: false)
    end
  end

  describe 'GET crop' do
    before do
      Tenon::Asset.stub(:find)
    end

    it 'should not render the layout' do
      get :crop, id: 1
      expect(response).to render_template(layout: false)
    end
  end

  describe 'POST create' do
    let(:params) { { 'test' => 'test' } }
    it 'should instantiate an Asset' do
      expect(Tenon::Asset).to receive(:new).with(params) { double.as_null_object }
      post :create, asset: params
    end

    it 'should attempt to save it' do
      Tenon::Asset.stub(:new) { asset }
      expect(asset).to receive(:save)
      post :create, asset: params
    end

    context 'with a valid Asset' do
      before do
        Tenon::Asset.stub(:new) { asset }
        asset.stub(:save) { true }
      end

      it 'should set flash[:notice]' do
        post :create, asset: params
        expect(controller.flash[:notice]).not_to be_nil
      end

      it "should redirect to '/tenon/asset-library'" do
        post :create, asset: params
        expect(response).to redirect_to '/tenon/asset-library'
      end
    end

    context 'with an invalid Asset' do
      before do
        Tenon::Asset.stub(:new) { asset }
        asset.stub(:save) { false }
        asset.stub(:errors) { { anything: 'will do' } }
      end

      it 'should not set flash[:notice]' do
        post :create, asset: params, format: 'json'
        expect(controller.flash[:notice]).to be_nil
      end

      it 'should render the errors' do
        post :create, asset: params, format: 'json'
        expect(JSON.parse(response.body).keys).to include('errors')
      end
    end
  end

  describe 'PATCH update' do
    before do
      Tenon::Asset.stub(:find) { double.as_null_object }
    end

    it 'should find an asset' do
      expect(Tenon::Asset).to receive(:find).with('1')
      patch :update, asset: { test: 'test' }, id: 1
    end

    context 'when creating a duplicate' do
      let(:existing_asset) { double(attachment: 'test') }
      let(:new_asset) { double(cropping?: false).as_null_object }
      let(:params) { { 'test' => 'test', 'duplicate' => '1' } }

      before do
        Tenon::Asset.stub(:find) { existing_asset }
        Tenon::Asset.stub(:new) { new_asset }
      end

      it 'should create a new asset' do
        expect(Tenon::Asset).to receive(:new).with(params)
        patch :update, asset: params, id: 1
      end

      it "should copy the existing asset's attachment to the new asset" do
        expect(new_asset).to receive(:attachment=).with(existing_asset.attachment)
        patch :update, asset: params, id: 1
      end

      it 'should save and reset the crop field on the new asset' do
        expect(new_asset).to receive(:save)
        expect(new_asset).to receive(:crop_x=) { nil }
        patch :update, asset: params, id: 1
      end

      it 'should not be reprocessed again' do
        attachment = double
        new_asset.stub(:attachment) { attachment }
        expect(attachment).not_to receive(:reprocess!)
        patch :update, asset: params, id: 1
      end

      it 'should be decorated' do
        expect(new_asset).to receive(:decorate)
        patch :update, asset: params, id: 1
      end

      it 'should render success' do
        patch :update, asset: params, id: 1, format: 'json'
        expect(response).to be_success
      end
    end

    context 'when not creating a duplicate' do
      let(:existing_asset) do
        double(attachment: 'test', cropping?: cropping).as_null_object
      end
      let(:params) { { 'test' => 'test' } }
      let(:cropping) { nil }

      before do
        Tenon::Asset.stub(:find) { existing_asset }
      end

      it 'should attempt to update the attributes' do
        expect(existing_asset).to receive(:update_attributes).with(params)
        patch :update, asset: params, id: 1
      end

      it 'should decorate the asset' do
        expect(existing_asset).to receive(:decorate)
        patch :update, asset: params, id: 1
      end

      it 'should render success' do
        patch :update, asset: params, id: 1, format: 'json'
        expect(response).to be_success
      end

      context 'when not cropping' do
        it 'should not reprocess the asset' do
          attachment = double
          existing_asset.stub(:attachment) { attachment }
          expect(attachment).not_to receive(:reprocess!)
          patch :update, asset: params, id: 1
        end
      end

      context 'when cropping' do
        let(:cropping) { true }
        it 'should reprocess the asset' do
          attachment = double
          existing_asset.stub(:attachment) { attachment }
          expect(attachment).to receive(:reprocess!)
          patch :update, asset: params, id: 1
        end
      end
    end
  end
end
