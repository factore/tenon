module Tenon
  module PlatformHintsHelper
    def platform_hints(color)
      render 'tenon/shared/platform_hints', color: color
    end
  end
end
