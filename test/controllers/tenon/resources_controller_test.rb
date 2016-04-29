require 'test_helper'
require 'will_paginate/array'

class TestResource
  def self.model_name
    ActiveModel::Name.new(TestResource)
  end

  def initialize(params = {})
    @params = params
  end

  def update_attributes(params = {})
    @params = params
  end

  def decorate
    self
  end

  def destroy
    true
  end

  def save
    true
  end

  def valid?
    true
  end

  def to_model
    self
  end

  def model_name
    ActiveModel::Name.new(self.class)
  end

  def persisted?
    true
  end

  def errors
    {}
  end
end

class TestResourcePolicy < Tenon::ApplicationPolicy
end

module Tenon
  class BaseController < ActionController::Base
    include Pundit

    def xhr_or_js?
      false
    end
  end

  class TestResourcesController < ResourcesController
    def resource_params
      params.require(:test_resource).permit!
    end
  end

  class ResourcesControllerTest < ActionController::TestCase
    tests TestResourcesController

    def setup
      TestResource.stubs(:table_name).returns('test_resources')
      TestResource.stubs(:where).returns(TestResource)
      TestResource.stubs(:find).returns(TestResource.new)
      TestResource.stubs(:decorate).returns(TestResource)
      TestResource.stubs(:paginate).returns([].paginate)

      admin = stub(admin?: true)
      @controller.stubs(:current_user).returns(admin)
      @_routes = Engine.routes
      @routes = @_routes
      @routes.draw do
        resources :test_resources, except: :show
      end
    end

    def teardown
      @routes = @_routes
    end

    def test_params
      { test_resource: { foo: 'bar' } }
    end

    # Non-admin
    def setup_user
      user = stub(admin?: false, super_admin?: false, contributor?: false)
      @controller.stubs(:current_user).returns(user)
    end

    test 'non-admin cannot GET index' do
      setup_user
      assert_raises(Pundit::NotAuthorizedError) do
        get :index
      end
    end

    test 'non-admin cannot GET new' do
      setup_user
      assert_raises(Pundit::NotAuthorizedError) do
        get :new
      end
    end

    test 'non-admin cannot GET edit' do
      setup_user
      assert_raises(Pundit::NotAuthorizedError) do
        get :edit, id: 1
      end
    end

    test 'non-admin cannot POST create' do
      setup_user
      assert_raises(Pundit::NotAuthorizedError) do
        post :create, test_resource: { foo: :bar }
      end
    end

    test 'non-admin cannot PUT update' do
      setup_user
      assert_raises(Pundit::NotAuthorizedError) do
        put :update, id: 1, test_resource: { foo: :bar }
      end
    end

    test 'non-admin cannot DELETE destroy' do
      setup_user
      assert_raises(Pundit::NotAuthorizedError) do
        delete :destroy, id: 1
      end
    end

    test 'admin can GET index' do
      get :index
      assert_response :success
    end

    test 'admin GET index with format json assigns @test_resources' do
      get :index, format: :json
      assert_not_nil assigns(:test_resources)
    end

    # GET new
    test 'admin can GET new' do
      get :new
      assert_response :success
    end

    test 'admin GET new assigns @test_resource' do
      get :new
      assert_not_nil assigns(:test_resource)
    end

    # GET edit
    test 'admin can GET edit' do
      get :edit, id: 1
      assert_response :success
    end

    test 'admin GET edit assigns @test_resource' do
      get :edit, id: 1
      assert_not_nil assigns(:test_resource)
    end

    # POST create
    test 'admin can POST create' do
      post :create, test_params
      assert_response :redirect
    end

    test 'admin POST create assigns @test_resource' do
      post :create, test_params
      assert_not_nil assigns(:test_resource)
    end

    test 'admin POST create HTML invalid renders new action' do
      TestResource.any_instance.stubs(:valid?).returns(false)
      post :create, test_params
      assert_template :new
    end

    test 'admin POST create JSON invalid responds 422' do
      TestResource.any_instance.stubs(:valid?).returns(false)
      post :create, test_params.merge(format: :json)
      assert_response 422
    end

    # PUT update
    test 'admin can PUT update' do
      put :update, test_params.merge(id: 1)
      assert_response :redirect
    end

    test 'admin PUT update assigns @test_resource' do
      put :update, test_params.merge(id: 1)
      assert_not_nil assigns(:test_resource)
    end

    test 'admin PUT update HTML invalid renders edit action' do
      TestResource.any_instance.stubs(:valid?).returns(false)
      put :update, test_params.merge(id: 1)
      assert_template :edit
    end

    test 'admin PUT update JSON invalid responds 422' do
      TestResource.any_instance.stubs(:valid?).returns(false)
      put :update, test_params.merge(id: 1, format: :json)
      assert_response 422
    end

    # DELETE destroy
    test 'admin can DELETE destroy' do
      delete :destroy, id: 1
      assert_response :redirect
    end

    test 'admin DELETE destroy assigns @test_resource' do
      delete :destroy, id: 1
      assert_not_nil assigns(:test_resource)
    end

    test 'admin DELETE destroy JSON invalid responds 422' do
      TestResource.any_instance.stubs(:destroy).returns(false)
      delete :destroy, id: 1, format: :json
      assert_response 422
    end
  end
end
