class Tenon::PostsController < Tenon::ResourcesController
  before_filter :get_collections

  def update
    params[:post][:post_category_ids] ||= []
    super
  end

  private

  def resource_params
    params.require(:post).permit!
  end

  def get_collections
    @categories = Tenon::PostCategory.order(:title)
  end

  def search_args
    [
      'title ILIKE :q OR content ILIKE :q',
      { :q => "%#{params[:q].downcase}%" }
    ]
  end
end
