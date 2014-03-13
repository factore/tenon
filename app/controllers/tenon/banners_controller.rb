class Tenon::BannersController < Tenon::ResourcesController
  private

  def resource_params
    params.require(:banner).permit!
  end
end
