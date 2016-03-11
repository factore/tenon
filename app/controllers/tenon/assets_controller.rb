module Tenon
  class AssetsController < Tenon::ResourcesController
    def edit
      render layout: false
    end

    def update
      if resource_params[:duplicate] == '1'
        new_asset = Tenon::Asset.new(resource_params)
        authorize(new_asset)
        new_asset.attachment = @asset.attachment
        new_asset.save
        new_asset.crop_x = nil
        working_asset = new_asset
      else
        working_asset = Asset.find(params[:id])
        authorize(working_asset)
        working_asset.update_attributes(resource_params)
      end
      working_asset.attachment.reprocess! if working_asset.cropping?
      @asset = working_asset.decorate

      respond_to do |format|
        format.html do
          if @asset.valid?
            redirect_to after_update_path
          else
            render action: :edit
          end
        end
        format.json do
          render json: @asset
        end
      end
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
