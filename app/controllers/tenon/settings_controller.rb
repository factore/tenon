module Tenon
  class SettingsController < Tenon::BaseController
    def update
      authorize! :update, Tenon::MySettings
      # force_boolean(params[:settings])
      params[:settings].each { |key, value| Tenon::MySettings.send((key + '=').to_sym, value) }
      flash[:notice] = 'Your settings have been saved.'
      redirect_to settings_path
    end

    def show
      authorize! :update, Tenon::MySettings
      @settings = Tenon::MySettings
    end

    # private

    # we want some settings to be typecast into boolean values
    # def force_boolean(settings)
    #   [:ecommerce_live, :use_coupons, :flat_rate_shipping, :integrated_payments].each do |key|
    #     if settings[key] == 'true'
    #       settings[key] = true
    #     else
    #       settings[key] = false
    #     end
    #   end
    # end
  end
end
