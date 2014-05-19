module Tenon
  class SettingsController < Tenon::BaseController
    def update
      authorize! :update, Tenon::MySettings
      params[:settings].each { |key, value| Tenon::MySettings.send((key + '=').to_sym, value) }
      flash[:notice] = 'Your settings have been saved.'
      redirect_to settings_path
    end

    def show
      authorize! :update, Tenon::MySettings
      @settings = Tenon::MySettings
    end
  end
end
