require 'spec_helper'

describe Tenon::IndexController do
  routes { Tenon::Engine.routes }

  let(:user) do
    double(
      staff?: true,
      super_admin?: false,
      admin?: true
    )
  end
  let(:generator) { double(generate: 'test') }

  before do
    controller.stub(:current_user) { user }
    stub_const('Tenon::WarningGenerator', generator)
  end

  describe 'GET index' do
    it 'should assign the warnings from the Tenon::WarningGenerator' do
      get :index
      expect(assigns[:warnings]).to eq Tenon::WarningGenerator.generate
    end

    it 'should assign the callouts' do
      get :index
      expect(assigns[:tenon_callouts]).to eq Tenon::TenonCallout.published
    end
  end
end
