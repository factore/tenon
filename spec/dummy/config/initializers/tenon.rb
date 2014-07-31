# This configuration block is for config that should be specified
# by the site developer.  There is a Settings module built into Tenon
# where you can expose other settings to your client.
Tenon.configure do |config|
  # Set up grid config for the front end.  This is done here so that we can
  # present accurate sizing
  config.front_end = {
    breakpoints: {
      desktop: 1400,
      laptop: 960,
      tablet: 768
    },
    columns: 24,
    gutter: 20,

    content_columns: {
      default: 18
    }
  }

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
