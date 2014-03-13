class Tenon::GalleriesController < Tenon::ResourcesController
  private

  def resource_params
    params.require(:gallery).permit!
  end
end
