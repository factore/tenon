module Tenon
  class Configuration
    attr_accessor :grid

    def grid
      @grid ||= GridConfiguration.new
    end

    class GridConfiguration
      attr_accessor :columns, :gutter, :content_columns

      def initialize
        @columns = 24
        @gutter = 20
        @content_columns = {
          default: 18
        }
      end
    end
  end
end
