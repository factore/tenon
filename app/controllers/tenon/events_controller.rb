module Tenon
  class EventsController < Tenon::ResourcesController
    private

    def resource_params
      params.require(:event).permit!
    end
  end
end
