require 'spec_helper'

describe Tenon::SettingsController do
  routes { Tenon::Engine.routes }

  let(:settings) { double.as_null_object }
  before do
    controller.stub(:current_user) { user }
    stub_const('Tenon::MySettings', settings)
  end

  context 'as not an admin' do
    let(:user) do
      double(
        staff?: false,
        is_super_admin?: false,
        is_admin?: false
      )
    end

    describe 'PATCH update' do
      it 'should redirect to /login' do
        patch :update
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'GET show' do
      it 'should redirect to /login' do
        get :show
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  context 'as an admin' do
    let(:user) do
      double(
        staff?: true,
        is_super_admin?: false,
        is_admin?: true
      )
    end

    describe 'PATCH update' do
      it 'should assign a setting for each param setting submitted' do
        expect(Tenon::MySettings).to receive(:one=).with('one')
        expect(Tenon::MySettings).to receive(:two=).with('two')
        patch :update, settings: { one: 'one', two: 'two' }
      end

      it 'should set the flash' do
        patch :update, settings: { one: 'one', two: 'two' }
        expect(controller.flash[:notice]).not_to be_blank
      end
    end

    describe 'GET show' do
      it 'should assign settings to Tenon::MySettings' do
        get :show
        expect(assigns[:settings]).to eq(Tenon::MySettings)
      end
    end
  end
end
