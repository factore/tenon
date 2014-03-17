module Tenon
  class TenonCalloutsController < Tenon::ResourcesController
    def resource_params
      params.require(:tenon_callout).permit!
    end
  end
end
