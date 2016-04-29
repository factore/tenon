module Tenon
  class ItemVersionsController < Tenon::BaseController
    respond_to :html, :json

    def create
      @item_version = ItemVersion.new(resource_params)
      item_params = @item_version.item_type.gsub('Tenon::', '').underscore
      @item_version.attrs = params[item_params]
      @item_version.creator_id = current_user.id
      @item_version.save
      respond_to do |format|
        format.json { render status: 200, nothing: true }
      end
    end

    def new
      @item_version = ItemVersion.new(
        item_id: params[:item_id],
        item_type: params[:item_type]
      )

      respond_to do |format|
        format.html { render layout: false }
      end
    end

    def index
      respond_to do |format|
        # Modal
        format.html { render layout: false }

        format.json do
          params.delete(:item_id) if params[:item_id] == ''
          @item_versions = ItemVersion
            .where(params.slice(:item_type, :item_id).permit!)
            .paginate(page: params[:page], per_page: 5)

          serializer = ActiveModel::Serializer.serializer_for(ItemVersion.new)
          respond_with(
            @item_versions,
            serializer: Tenon::PaginatingSerializer,
            each_serializer: serializer,
            root: 'records',
            serialization_scope: view_context
          )
        end
      end
    end

    private

    def resource_params
      params.require(:item_version).permit!
    end

    def default_serializer_options
      { root: 'record', scope: view_context }
    end
  end
end
