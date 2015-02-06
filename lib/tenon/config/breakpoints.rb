module Tenon
  class Configuration
    attr_accessor :breakpoints

    def breakpoints
      @breakpoints ||= BreakpointConfiguration.new
    end

    class BreakpointConfiguration
      attr_accessor :front_end, :back_end, :grid

      def initialize
        # Define all your breakpoints and associated tenon_content widths.
        # This is necessary because you may have multiple models with tenon_content
        # with different maximum widths and therefore different widths at various
        # breakpoints. By getting more precise with these widths we can serve the
        # most efficient responsive images to the front end.
        @front_end = {
          full: {
            browser: 1920, # the width of the browser for this breakpoint
            default: 1920, # default tenon_content width for piece's without specific widths
            page: 1920, # the width of tenon_content for Pages
            post: 1920 # the width of tenon_content for Posts
          },
          desktop: {
            browser: 1400,
            default: 1400,
            page: 1400,
            post: 1400
          },
          laptop: {
            browser: 960,
            default: 960,
            page: 960,
            post: 960
          },
          tablet: {
            browser: 768,
            default: 768,
            page: 768,
            post: 768
          }
        }

        # set up the back-end breakpoints and associated tenon_content widths since
        # we know what they always are
        @back_end = {
          full: {
            browser: 1920,
            default: 1225
          },
          desktop: {
            browser: 1400,
            default: 740
          },
          laptop: {
            browser: 960,
            default: 680
          },
          tablet: {
            browser: 768,
            default: 750
          }
        }

        @grid = {
          columns: 24,
          gutter: 20,

          content_columns: {
            default: 18
          }
        }
      end
    end
  end
end
