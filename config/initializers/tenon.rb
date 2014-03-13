require 'tenon.rb'
require 'tenon/config/events.rb'
require 'tenon/can_be_foreign.rb'
require 'tenon/can_have_comments.rb'
require 'tenon/has_asset.rb'
require 'tenon/i18n_lookup.rb'
require 'tenon/proxy_attachment.rb'
require 'tenon/asset_style_generator.rb'
require 'tenon/reorderable.rb'
require 'tenon/tenon_content.rb'
require 'tenon/warning_generator.rb'

# This configuration block is for config that should be specified
# by the site developer.  There is a Settings module built into Tenon
# where you can expose other settings to your client.
Tenon.configure do |config|
  # Set up grid config for the front end.  This is done here so that we can
  # present accurate sizing
  config.front_end = {
    :breakpoints => {
      :full => 1400,
      :desktop => 1024,
      :laptop => 960,
      :tablet => 768
    },
    :columns => 24,
    :gutter => 20,

    :content_columns => {
      :default => 18
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
