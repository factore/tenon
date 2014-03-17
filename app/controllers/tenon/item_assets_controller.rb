module Tenon
  class ItemAssetsController < Tenon::BaseController
    layout false

    def new
      @multiple = params[:multiple]
    end
  end
end
