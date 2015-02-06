class Tenon::MenusController < Tenon::ResourcesController


    def resource_params
      params.require(:menu).permit!
    end
end
