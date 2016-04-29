require 'tenon/engine'
require 'tenon/config/breakpoints.rb'
require 'tenon/config/routing.rb'
require 'tenon/config/grid.rb'
require 'tenon/can_be_foreign.rb'
require 'tenon/filterers/base_filterer.rb'
require 'tenon/has_asset.rb'
require 'tenon/has_history.rb'
require 'tenon/i18n_lookup.rb'
require 'tenon/proxy_attachment.rb'
require 'tenon/asset_style_generator.rb'
require 'tenon/reorderable.rb'
require 'tenon/tenon_content.rb'

module Tenon
  class << self
    attr_accessor :config
  end

  def self.configure
    self.config ||= Configuration.new
    yield config
  end

  class Configuration
    attr_accessor :mobile_layout, :languages, :seo_callout, :front_end,
                  :after_create_path, :after_update_path, :client_color,
                  :primary_color
  end
end
