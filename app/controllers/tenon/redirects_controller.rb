module Tenon
  class RedirectsController < Tenon::ResourcesController
    def resource_params
      params.require(:redirect).permit!
    end

    def toggle_active
      respond_to do |format|
        if @redirect.toggle_active!
          format.json { render json: @redirect.to_json }
          format.html { flash[:notice] = 'redirect approved.' and redirect_to redirects_path }
        else
          format.json { render status: 500, nothing: true }
          format.html { flash[:warning] = 'Error approving redirect.' and redirect_to redirects_path }
        end
      end
    end

    private

    def search_args
      ["#{klass.table_name}.in ILIKE ? OR #{klass.table_name}.out ILIKE ?", "%#{params[:q]}%", "%#{params[:q]}%"]
    end
  end
end
