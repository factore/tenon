module Tenon
  class BannersController < Tenon::ResourcesController
    private

    def resource_params
      params.require(:banner).permit!
    end
  end
end
