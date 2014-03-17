module Tenon
  class IndexController < Tenon::BaseController
    def index
      @warnings = Tenon::WarningGenerator.generate
      @tenon_callouts = Tenon::TenonCallout.published
    end
  end
end
