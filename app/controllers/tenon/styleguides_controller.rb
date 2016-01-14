module Tenon
  class StyleguidesController < Tenon::BaseController
    respond_to :html

    def index
      @context_title = 'Styleguide'
      @mock = Tenon::StyleguideMock.new
    end
  end
end
