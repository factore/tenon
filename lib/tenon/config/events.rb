# File: lib/tenon/videos.rb
# Adds configuration options for videos
# eg.
#
# Tenon.configure do |config|
#   config.events.display = :calendar
# end

module Tenon
  class Configuration
    attr_accessor :events

    def events
      @events ||= EventConfiguration.new
    end

    class EventConfiguration
      attr_accessor :display

      def initialize
        @display = :list
      end

      def display
        @display.to_sym
      end
    end
  end
end
