require 'active_model_serializers'
require 'client_side_validations'
require 'cocoon'
require 'date_time_attribute'
require 'draper'
require 'factory_girl'
require 'factory_girl_rails'
require 'haml'
require 'jquery-fileupload-rails'
require 'jquery-rails'
require 'mime-types'
require 'non-stupid-digest-assets'
require 'paperclip'
require 'paperclip_processors/cropper'
require 'pundit'
require 'rails-settings-cached'
require 'react-rails'
require 'uuidtools'
require 'will_paginate'

# Dummy app gems
require 'humanizer'
require 'awesome_nested_set'
require 'gravatar_image_tag'
require 'uglifier'

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

    if Rails.env.test?
      config.paths['app/views'] << "test/fixtures/views"
    end

    initializer :assets do |config|
      Rails.application.config.assets.precompile += [
        'tenon/application.js',
        'tenon/tenon_manifest.js',
        'tenon/*.png'
      ]
    end
  end
end
