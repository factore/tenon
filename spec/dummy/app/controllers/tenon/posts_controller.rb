module Tenon
  class PostsController < Tenon::ResourcesController
    before_filter :load_collections

    def update
      params[:post][:post_category_ids] ||= []
      super
    end

    private

    def resource_params
      params.require(:post).permit!
    end

    def filterer
      PostFilterer.new(policy_scope(Post), params, ['posts.title'])
    end

    def load_collections
      @categories = PostCategory.order(:title)
      @users = User.exclude_super_admins.approved
    end
  end
end
