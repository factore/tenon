require 'spec_helper'

describe Tenon::ItemAssetsController do
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
  end

  describe 'GET new' do
    it "should assign @multiple to params[:multiple]" do
      get :new, multiple: '1'
      expect(assigns[:multiple]).to eq('1')
    end

    it "should not render a layout" do
      get :new
      expect(response).to render_template(layout: false)
    end
  end
end
