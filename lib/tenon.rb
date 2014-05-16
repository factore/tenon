require 'tenon/engine'
require 'tenon/config/events.rb'
require 'tenon/can_be_foreign.rb'
require 'tenon/can_have_comments.rb'
require 'tenon/has_asset.rb'
require 'tenon/has_history.rb'
require 'tenon/i18n_lookup.rb'
require 'tenon/proxy_attachment.rb'
require 'tenon/asset_style_generator.rb'
require 'tenon/reorderable.rb'
require 'tenon/tenon_content.rb'
require 'tenon/warning_generator.rb'

module Tenon
  class << self
    attr_accessor :config
  end

  def self.configure
    self.config ||= Configuration.new
    yield config
  end

  class Configuration
    attr_accessor :mobile_layout, :languages, :seo_callout, :front_end
  end
end
