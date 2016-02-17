# We test the GalleriesController as it inherits completely from
# resources controller.  Other controllers should only test
# methods that they override.

require 'spec_helper'

describe Tenon::GalleriesController do
  routes { Tenon::Engine.routes }

  let(:gallery) { mock_model(Tenon::Gallery).as_null_object }

  before do
    controller.stub(:current_user) { user }
    controller.stub(:polymorphic_index_path) { '/tenon/galleries' }
  end

  context 'with an administrator' do
    let(:user) do
      double(
        staff?: true,
        is_super_admin?: false,
        is_admin?: true
      )
    end

    describe 'GET index.html' do
      it 'should respond with success' do
        get :index, format: 'html'
        expect(response).to be_success
      end

      it 'should render the template' do
        get :index, format: 'html'
        expect(response).to render_template('index')
      end

      it 'should set params[:page] to 1' do
        get :index, format: 'html'
        expect(controller.params[:page]).to eq(1)
      end

      it 'should not override a valid page parameter' do
        get :index, format: 'html', page: '5'
        expect(controller.params[:page]).to eq('5')
      end
    end

    describe 'GET index.json' do
      before do
        [:all, :where, :paginate].each do |query|
          Tenon::Gallery.stub(query) { Tenon::Gallery }
        end
      end

      it 'should respond with success' do
        get :index, format: 'json'
        expect(response).to be_success
      end

      it 'should render the template' do
        get :index, format: 'json'
        expect(response).to render_template('index')
      end

      it 'should attempt to get all the resources' do
        expect(Tenon::Gallery).to receive(:all) { Tenon::Gallery }
        get :index, format: 'json'
      end

      it 'should paginate the resources' do
        expect(Tenon::Gallery).to receive(:paginate).and_return(Tenon::Gallery)
        get :index, format: 'json'
      end

      it 'should decorate the resources' do
        expect(Tenon::PaginatingDecorator).to receive(:decorate).with(Tenon::Gallery)
        get :index, format: 'json'
      end

      it 'should search the resources when params[:q] is supplied' do
        search_args = ['tenon_galleries.title ILIKE ?', '%test%']
        expect(Tenon::Gallery).to receive(:where).with(search_args)
        get :index, format: 'json', q: 'test'
      end
    end

    describe 'GET new' do
      it 'should respond with success' do
        get :new
        expect(response).to be_success
      end

      it 'should render the template' do
        get :new
        expect(response).to render_template('new')
      end

      it 'should instantiate a resource' do
        expect(Tenon::Gallery).to receive(:new) { gallery }
        get :new
      end
    end

    describe 'GET edit' do
      before do
        Tenon::Gallery.stub(:find) { gallery }
      end

      it 'should respond with success' do
        get :edit, id: 1
        expect(response).to be_success
      end

      it 'should render the template' do
        get :edit, id: 1
        expect(response).to render_template('edit')
      end

      it 'should find a resource' do
        expect(Tenon::Gallery).to receive(:find).with('1')
        get :edit, id: 1
      end
    end

    describe 'POST create' do
      before do
        Tenon::Gallery.stub(:new) { gallery }
      end

      let(:params) { { 'test' => 'test' } }

      it 'should instantiate a resource' do
        expect(Tenon::Gallery).to receive(:new).with(params) { gallery }
        post :create, gallery: params
      end

      it 'should attempt to save it' do
        expect(gallery).to receive(:save)
        post :create, gallery: params
      end

      context 'with an unsuccessful save' do
        before do
          gallery.stub(:errors) { { anything: 'will do' } }
        end

        it 'should respond with success' do
          post :create, gallery: params
          expect(response).to be_success
        end

        it 'should render the new template' do
          post :create, format: 'html', gallery: params
          expect(response).to render_template('new')
        end
      end

      context 'with a successful save' do
        it 'should redirect to index' do
          post :create, gallery: params
          expect(response).to redirect_to("/tenon/galleries/#{assigns[:gallery].id}/edit")
        end
      end
    end

    describe 'PATCH update' do
      before do
        Tenon::Gallery.stub(:find) { gallery }
      end

      let(:params) { { 'test' => 'test' } }

      it 'should find a resource' do
        expect(Tenon::Gallery).to receive(:find).with('1') { gallery }
        patch :update, gallery: params, id: 1
      end

      it 'should attempt to update it' do
        expect(gallery).to receive(:update_attributes).with(params)
        patch :update, gallery: params, id: 1
      end

      context 'with an unsuccessful save' do
        before do
          gallery.stub(:errors) { { anything: 'will do' } }
          gallery.stub(:update_attributes) { false }
        end

        it 'should respond with success' do
          patch :update, gallery: params, id: 1
          expect(response).to be_success
        end

        it 'should render the edit template' do
          patch :update, gallery: params, id: 1
          expect(response).to render_template('edit')
        end

        it 'should not set the flash' do
          patch :update, gallery: params, id: 1
          expect(controller.flash[:notice]).to be_blank
        end
      end

      context 'with a successful save' do
        it 'should redirect to index' do
          patch :update, gallery: params, id: 1
          expect(response).to redirect_to("/tenon/galleries/#{assigns[:gallery].id}/edit")
        end

        it 'should set the flash' do
          patch :update, gallery: params, id: 1
          expect(controller.flash[:notice]).not_to be_blank
        end
      end
    end

    describe 'DELETE destroy' do
      let(:gallery) { double.as_null_object }

      before do
        Tenon::Gallery.stub(:find) { gallery }
      end

      it 'should find the resource' do
        expect(Tenon::Gallery).to receive(:find).with('1') { gallery }
        delete :destroy, id: 1
      end

      it 'should try to destroy the resource' do
        expect(gallery).to receive(:destroy)
        delete :destroy, id: 1
      end

      context 'on successful destruction' do
        before do
          gallery.stub(:destroy) { true }
        end

        it 'should redirect to index' do
          delete :destroy, id: 1
          expect(response).to redirect_to('/tenon/galleries')
        end
      end

      context 'on failure' do
        let(:errors) { { anything: 'will do' } }
        before do
          gallery.stub(:destroy) { false }
          gallery.stub(:errors) { errors }
        end

        it 'should render errors' do
          delete :destroy, id: 1, format: 'json'
          expect(response.body).to eq({ 'errors' => errors }.to_json)
        end
      end
    end
  end

  context 'when not an administrator' do
    let(:user) { double(staff?: false) }

    describe 'GET index' do
      it 'should redirect' do
        get :index
        expect(response).to be_redirect
      end
    end

    describe 'GET new' do
      it 'should redirect' do
        get :new
        expect(response).to be_redirect
      end
    end

    describe 'GET edit' do
      it 'should redirect' do
        get :edit, id: 1
        expect(response).to be_redirect
      end
    end

    describe 'POST create' do
      it 'should redirect' do
        post :create, gallery: {}
        expect(response).to be_redirect
      end
    end

    describe 'PATCH update' do
      it 'should redirect' do
        patch :update, id: 1
        expect(response).to be_redirect
      end
    end

    describe 'DELETE destroy' do
      it 'should redirect' do
        delete :destroy, id: 1
        expect(response).to be_redirect
      end
    end
  end

  context 'when not logged in at all' do
    let(:user) { nil }

    describe 'GET index' do
      it 'should redirect' do
        get :index
        expect(response).to be_redirect
      end
    end

    describe 'GET new' do
      it 'should redirect' do
        get :new
        expect(response).to be_redirect
      end
    end

    describe 'GET edit' do
      it 'should redirect' do
        get :edit, id: 1
        expect(response).to be_redirect
      end
    end

    describe 'POST create' do
      it 'should redirect' do
        post :create, gallery: {}
        expect(response).to be_redirect
      end
    end

    describe 'PATCH update' do
      it 'should redirect' do
        patch :update, id: 1
        expect(response).to be_redirect
      end
    end

    describe 'DELETE destroy' do
      it 'should redirect' do
        delete :destroy, id: 1
        expect(response).to be_redirect
      end
    end
  end
end
