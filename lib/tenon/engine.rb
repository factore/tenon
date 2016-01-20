require 'browserify-rails'
require 'cancan'
require 'cocoon'
require 'coffee-rails'
require 'date_time_attribute'
require 'draper'
require 'dynamic_form'
require 'eco'
require 'font-awesome-rails'
require 'haml'
require 'jbuilder'
require 'jquery-fileupload-rails'
require 'jquery-rails'
require 'jquery-ui-rails'
require 'lodash-rails'
require 'mediaelement_rails'
require 'mime-types'
require 'neat'
require 'non-stupid-digest-assets'
require 'normalize-rails'
require 'paperclip'
require 'paperclip_processors/cropper'
require 'pickadate-rails'
require 'rails-settings-cached'
require 'react-rails'
require 'sass-rails'
require 'sprockets/es6'
require 'uuidtools'
require 'will_paginate'

module Tenon
  class Engine < ::Rails::Engine
    isolate_namespace Tenon
    config.app_generators do |g|
      g.templates.unshift File.expand_path('../../templates', __FILE__)
    end

    config.to_prepare do
     ApplicationController.helper(Tenon::TenonHelper)
     ApplicationController.helper(Tenon::BreadcrumbsHelper)
    end

    initializer :assets do |config|
      Rails.application.config.assets.precompile += ['tenon/tenon_manifest.js', 'tenon/tenon.scss', 'tenon/*.png']
      Rails.application.config.browserify_rails.commandline_options = '-t babelify'
      Rails.application.config.browserify_rails.paths << lambda { |p| p.start_with?(Engine.root.join("app").to_s) }
      Rails.application.config.browserify_rails.use_browserifyinc = true
    end
  end
end
