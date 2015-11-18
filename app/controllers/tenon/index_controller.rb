module Tenon
  class IndexController < Tenon::BaseController
    def index
      @warnings = Tenon::WarningGenerator.generate(root_path)
    end
  end
end
