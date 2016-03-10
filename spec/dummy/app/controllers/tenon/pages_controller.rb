module Tenon
  class PagesController < Tenon::ResourcesController
    before_filter :load_potential_parents, only: [:new, :edit, :update, :create]

    def create
      params[:page][:creator_id] = current_user.id
      params[:page][:updater_id] = current_user.id
      super
    end

    def reorder
      authorize(Page)
      @pages = Page.reorder!(params[:item_list], params[:parent_id])
      render nothing: true
    end

    private

    def before_new
      resource.parent_id = params[:parent_id]
    end

    def before_update
      resource.updater_id = current_user.id
    end

    def load_potential_parents
      id = params[:id] || 0
      @potential_parents = Page.where.not(id: id).order(:lft).decorate
    end

    def resource_params
      params.require(:page).permit!
    end
  end
end
