module Tenon
  class IndexController < Tenon::BaseController
    def index
      @warnings = Tenon::WarningGenerator.generate(root_path)
      @tenon_callouts = Tenon::TenonCallout.published
    end
  end
end
