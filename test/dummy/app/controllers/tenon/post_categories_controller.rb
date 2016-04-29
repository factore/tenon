module Tenon
  class PostCategoriesController < Tenon::ResourcesController
    private

    def resource_params
      params.require(:post_category).permit!
    end
  end
end
