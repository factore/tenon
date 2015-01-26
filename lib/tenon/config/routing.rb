# File: lib/tenon/videos.rb
# Adds configuration options for videos
# eg.
#
# Tenon.configure do |config|
#   config.events.display = :calendar
# end

module Tenon
  class Configuration
    attr_accessor :routing

    def routing
      @routing ||= RoutingConfiguration.new
    end

    class RoutingConfiguration
      attr_accessor :root

      def initialize
        @root = 'index#index'
      end
    end
  end
end
