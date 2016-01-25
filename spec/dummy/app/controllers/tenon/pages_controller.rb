module Tenon
  class PagesController < Tenon::ResourcesController
    before_filter :get_potential_parents, only: [:new, :edit, :update, :create]

    def index
      respond_to do |format|
        format.html
        format.json do
          if params[:q].blank?
            @pages = Page.order(:lft)
          else
            pages = Page.where(search_args).map { |p| [p.ancestors, p] }
            @pages = pages.flatten.uniq.sort_by(&:lft)
          end
        end
      end
    end

    def new
      resource.parent_id = params[:parent_id]
      super
    end

    def update
      resource.updater_id = current_user.id
      super
    end

    def create
      params[:page][:creator_id] = current_user.id
      params[:page][:updater_id] = current_user.id
      super
    end

    def reorder
      @pages = Page.reorder!(params[:item_list], params[:parent_id])
      render nothing: true
    end

    private

    def get_potential_parents
      id = params[:id] || 0
      @potential_parents = Page.order(:lft).decorate
    end

    def resource_params
      params.require(:page).permit!
    end
  end
end
