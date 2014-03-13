class Tenon::PostCategoriesController < Tenon::SimpleResourcesController
  private

  def resource_params
    params.require(:post_category).permit!
  end
end
