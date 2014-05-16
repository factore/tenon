module Tenon
  class ItemVersionsController < Tenon::BaseController
    def create
      @item_version = ItemVersion.new(resource_params)
      item_params = @item_version.item_type.gsub('Tenon::', '').underscore
      @item_version.attrs = params[item_params]
      @item_version.creator_id = current_user.id
      @item_version.save
      respond_to do |format|
        format.json
      end
    end

    def new
      @item_version = ItemVersion.new(
        item_id: params[:item_id],
        item_type: params[:item_type]
      )

      respond_to do |format|
        # Modal
        format.html { render layout: false }
      end
    end

    def index
      respond_to do |format|
        # Modal
        format.html { render layout: false }

        format.json {
          params.delete(:item_id) if params[:item_id] == ''
          @item_versions = ItemVersion.where(
            item_type: params[:item_type],
            item_id: params[:item_id]
          )
          .paginate(page: params[:page], per_page: 5)
        }
      end
    end

    private

    def resource_params
      params.require(:item_version).permit!
    end
  end
end
