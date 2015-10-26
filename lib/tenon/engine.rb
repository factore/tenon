require 'font-awesome-rails'
require 'awesome_nested_set'
require 'bourbon'
require 'browserify-rails'
require 'neat'
require 'cancan'
require 'cocoon'
require 'coffee-rails'
require 'daemons'
require 'devise'
require 'draper'
require 'dynamic_form'
require 'eco'
require 'gravatar_image_tag'
require 'haml'
require 'hpricot'
require 'httparty'
require 'humanizer'
require 'jbuilder'
require 'jquery-fileupload-rails'
require 'jquery-rails'
require 'jquery-ui-rails'
require 'js-routes'
require 'later_dude'
require 'launchy'
require 'lodash-rails'
require 'mediaelement_rails'
require 'medium-editor-rails'
require 'mime-types'
require 'nokogiri'
require 'non-stupid-digest-assets'
require 'normalize-rails'
require 'paperclip'
require 'rails-observers'
require 'rails-settings-cached'
require 'rdiscount'
require 'react-rails'
require 'resque/server'
require 'sass-rails'
require 'simple-rss'
require 'uglifier'
require 'uuidtools'
require 'will_paginate'
require 'yaml_db'
require 'paperclip_processors/cropper'

module Tenon
  class Engine < ::Rails::Engine
    isolate_namespace Tenon
    config.app_generators do |g|
      g.templates.unshift File.expand_path('../../templates', __FILE__)
    end

    initializer :assets do |config|
      Rails.application.config.assets.precompile += ['tenon/tenon_manifest.js', 'tenon/tenon.css']
      Rails.application.config.browserify_rails.commandline_options = '-t babelify'
      Rails.application.config.browserify_rails.paths << lambda { |p| p.start_with?(Engine.root.join("app").to_s) }
      # Rails.application.config.browserify_rails.use_browserifyinc = false
    end
  end
end
