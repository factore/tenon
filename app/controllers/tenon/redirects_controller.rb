module Tenon
  class RedirectsController < Tenon::ResourcesController
    def resource_params
      params.require(:redirect).permit!
    end

    private

    def search_args
      ["#{klass.table_name}.in ILIKE ? OR #{klass.table_name}.out ILIKE ?", "%#{params[:q]}%", "%#{params[:q]}%"]
    end
  end
end
