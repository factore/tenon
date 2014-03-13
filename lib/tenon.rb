require 'tenon/engine'

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
