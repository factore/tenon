# We test the PostCategoriesController as it inherits completely from
# resources controller.  Other controllers should only test
# methods that they override.  SimpleResourcesController inherits
# from Tenon::ResourcesController, there are only two actions to
# test here.

require 'spec_helper'

describe Tenon::PostCategoriesController do
  routes { Tenon::Engine.routes }

  let(:user) {
    double(
      :staff? => true,
      :is_super_admin? => false,
      :is_admin? => true
    )
  }

  before do
    controller.stub(:current_user) { user }
    controller.stub(:polymorphic_index_path) { '/tenon/banners' }
  end

  describe 'GET index' do
    it 'should instantiate a new resource' do
      expect(Tenon::PostCategory).to receive(:new)
      get :index
    end
  end

  describe 'GET edit' do
    before do
      Tenon::PostCategory.stub(:find) { double.as_null_object }
    end

    it 'should render the form partial' do
      get :edit, :id => 1
      expect(response).to render_template(:partial => 'tenon/post_categories/_form')
    end
  end
end
