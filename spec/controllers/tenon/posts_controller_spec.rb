require 'spec_helper'

describe Tenon::PostsController do
  routes { Tenon::Engine.routes }

  let(:user) {
    double(
      :staff? => true,
      :is_super_admin? => false,
      :is_admin? => true
    )
  }
  let(:post) { double.as_null_object }

  before do
    controller.stub(:current_user) { user }
    controller.stub(:polymorphic_index_path) { posts_path }
  end

  describe "PATCH update" do
    before do
      Tenon::Post.stub(:find) { double.as_null_object }
    end

    it "should instantiate the post_category_ids collection if it's empty" do
      patch :update, id: 1, post: {blah: 'blah'}
      expect(controller.params[:post][:post_category_ids]).to eq([])
    end
  end
end
