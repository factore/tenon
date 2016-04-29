require 'test_helper'

module Tenon
  class ItemAssetsControllerTest < ActionController::TestCase
    def setup
      @routes = Engine.routes
      user = stub(staff?: true, super_admin?: false, admin?: true)
      @controller.stubs(current_user: user)
    end

    test 'GET new assigns @multiple correctly' do
      get :new, multiple: '1'
      assert_equal assigns(:multiple), '1'
    end

    test 'GET new does not render the layout' do
      get :new
      assert_template layout: false
    end
  end
end
