require 'spec_helper'

describe Tenon::UsersController do
  routes { Tenon::Engine.routes }

  let(:user) {
    double(
      :staff? => true,
      :is_super_admin? => false,
      :is_admin? => true
    )
  }
  let(:user_dbl) { double.as_null_object }

  before do
    controller.stub(:current_user) { user }
  end

  describe 'GET index.html' do
    it "should be success" do
      get :index
      expect(response).to be_success
    end

    it "should render the index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET index.json' do
    before do
      [:all, :includes, :where, :not, :paginate].each do |query|
        Tenon::User.stub(query) { Tenon::User }
      end
    end

    context 'when current_user is_super_admin?' do
      before do
        user.stub(:is_super_admin?) { true }
      end

      it "should get all the users" do
        expect(Tenon::User).to receive(:all)
        get :index, format: 'json'
      end
    end

    context 'when current_user is_admin?' do
      # Proper settings from let statement at top

      it "should get everyone but the super admins" do
        expect(Tenon::User).to receive(:includes).with(:roles)
        expect(Tenon::User).to receive(:where)
        expect(Tenon::User).to receive(:not).with({tenon_roles: {title: 'Super Admin'}})
        get :index, format: 'json'
      end
    end

    context 'when params[:q] is passed' do
      it "should search the users" do
        search_args = ["email ILIKE ?", "%search%"]
        expect(Tenon::User).to receive(:where).with(search_args)
        get :index, format: 'json', q: 'search'
      end
    end

    it "should paginate the users" do
      expect(Tenon::User).to receive(:paginate)
      get :index, format: 'json'
    end
  end
end
