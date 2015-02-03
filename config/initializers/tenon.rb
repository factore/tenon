# This configuration block is for config that should be specified
# by the site developer.  There is a Settings module built into Tenon
# where you can expose other settings to your client.
Tenon.configure do |config|
  # Define all your breakpoints and associated tenon_content widths. This is necessary because you may have multiple models with tenon_content with different maximum widths and therefore different widths at various breakpoints. By getting more precise with these widths we can serve the most efficient responsive images to the front end.
  config.front_end = {
    breakpoints: {
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
    },

    columns: 24,
    gutter: 20,

    content_columns: {
      default: 18
    }
  }

  # set up the back-end breakpoints and associated tenon_content widths since we know what they always are
  config.back_end = {
    breakpoints: {
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
  }

  # Set platform hints color(s)
  config.client_color = '#9c0f17'
  config.primary_color = '#df222A'

  # Set the default after_update and after_create path
  # :edit or :index
  config.after_update_path = :edit
  config.after_create_path = :edit

  # Set up languages for front-end internationalization
  # Currently Tenon is anglo-centric so you don't need to
  # specify English.
  #
  # config.languages = {
  #   "French" => :fr,
  #   "German" => :de
  #   # etc.
  # }

  # Print out support instructions for your client
  # in the bottom right-hand corner of Tenon
  # config.support_instructions_in_layout = File.read("support.html")

  # Print out any additional SEO information you'd like
  # to display on the SEO tabs of supported modules
  # config.seo_callout = File.read("seo.html")

  # If you need to add further config options you can add them
  # in lib/tenon.rb as attr_accessors to Tenon::Configuration
end
