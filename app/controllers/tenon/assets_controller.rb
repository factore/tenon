module Tenon
  class AssetsController < Tenon::ResourcesController
    def index
      respond_to do |format|
        format.html
        format.json do
          @assets = Tenon::Asset.all
          @assets = @assets.where(search_args) if params[:q]
          @assets = @assets.with_type(params[:type]) unless params[:type].blank?
          @assets = @assets.paginate(per_page: 20, page: params[:page])
          @assets = Tenon::PaginatingDecorator.decorate(@assets)
        end
      end
    end

    def edit
      render layout: false
    end

    def create
      asset = Tenon::Asset.new(resource_params)
      flash[:notice] = 'Asset was successfully uploaded.' if asset.save && !request.xhr?
      @asset = asset.decorate
      respond_with(@asset, location: assets_path)
    end

    def update
      if resource_params[:duplicate] == '1'
        new_asset = Tenon::Asset.new(resource_params)
        new_asset.attachment = @asset.attachment
        new_asset.save
        new_asset.crop_x = nil
        working_asset = new_asset
      else
        working_asset = @asset
        working_asset.update_attributes(resource_params)
      end
      working_asset.attachment.reprocess! if working_asset.cropping?
      @asset = working_asset.decorate
      respond_with(@asset, location: polymorphic_index_path)
    end

    def crop
      render layout: false
    end

    private

    def resource_params
      params.require(:asset).permit!
    end

    def search_args
      [
        'attachment_file_name ILIKE :q OR title ILIKE :q',
        { q: "%#{params[:q]}%" }
      ]
    end
  end
end
