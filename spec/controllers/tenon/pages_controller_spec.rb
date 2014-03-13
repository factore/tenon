require 'spec_helper'

describe Tenon::PagesController do
  routes { Tenon::Engine.routes }

  let(:user) {
    double(
      :staff? => true,
      :is_super_admin? => false,
      :is_admin? => true
    )
  }
  let(:page) { double.as_null_object }

  before do
    controller.stub(:current_user) { user }
  end

  describe "GET index.html" do
    it "should render the index template" do
      get :index, format: 'html'
      expect(response).to render_template('index')
    end
  end

  describe "GET index.json" do
    context 'without params[q:]' do
      it "should get the pages and order them by lft" do
        expect(Tenon::Page).to receive(:order).with(:lft) { double.as_null_object }
        get :index, format: 'json'
      end
    end

    context 'with params[q:]' do
      it "should search the pages and then order them by lft" do
        args = ["title ILIKE ?", '%search%']
        expect(Tenon::Page).to receive(:where).with(args) { Tenon::Page }
        expect(Tenon::Page).to receive(:map) { Tenon::Page }
        expect(Tenon::Page).to receive(:flatten) { Tenon::Page }
        expect(Tenon::Page).to receive(:uniq) { Tenon::Page }
        expect(Tenon::Page).to receive(:sort_by) { Tenon::Page }
        get :index, format: 'json', q: 'search'
      end
    end
  end

  describe "GET new" do
    it "should set the parent_id to params[:parent_id]" do
      Tenon::Page.stub(:new) { page }
      get :new, parent_id: 1
      expect(assigns[:page]).to have_received(:parent_id=).with('1')
    end
  end

  describe 'POST reorder' do
    it "should reorder the pages" do
      expect(Tenon::Page).to receive(:reorder!).with(%w{1 2 3}, '1')
      post :reorder, item_list: [1,2,3], parent_id: 1
    end

    it "shouldn't render anything" do
      Tenon::Page.stub(:reorder!)
      post :reorder, item_list: [1,2,3], parent_id: 1
      expect(response.body).to eq(' ')
    end
  end
end
