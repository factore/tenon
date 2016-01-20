$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'tenon/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'tenon'
  s.version     = Tenon::VERSION
  s.authors     = ['factor[e] design initiative']
  s.email       = ['info@factore.ca']
  s.homepage    = 'http://factore.ca/tenon'
  s.summary     = 'A highly flexible mountable Rails CMS built for rapid application development.'
  s.description = 'A highly flexible mountable Rails CMS built for rapid application development.'

  s.files = Dir['{app,config,db,lib}/**/*', 'vendor/assets/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['spec/**/*'] - Dir['spec/dummy/**/*']

  s.add_development_dependency 'better_errors'
  s.add_development_dependency 'binding_of_caller'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'capybara-webkit'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'spring'
  s.add_development_dependency 'spring-commands-rspec'
  s.add_development_dependency 'quiet_assets'
  s.add_development_dependency 'launchy'

  # Dummy app gems
  s.add_dependency 'humanizer'
  s.add_dependency 'awesome_nested_set'
  s.add_dependency 'gravatar_image_tag'
  s.add_dependency 'uglifier'

  # The actual gem dependencies
  s.add_dependency 'rails', '5.0.0.beta1'

  s.add_dependency 'browserify-rails'
  s.add_dependency 'cancan'
  s.add_dependency 'cocoon'
  s.add_dependency 'coffee-rails'
  s.add_dependency 'coffee-script-source'
  s.add_dependency 'date_time_attribute'
  s.add_dependency 'dynamic_form'
  s.add_dependency 'eco'
  s.add_dependency 'font-awesome-rails'
  s.add_dependency 'haml'
  s.add_dependency 'ionicons-rails'
  s.add_dependency 'jbuilder'
  s.add_dependency 'jquery-fileupload-rails'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'jquery-ui-rails'
  s.add_dependency 'lodash-rails'
  s.add_dependency 'mediaelement_rails'
  s.add_dependency 'mime-types'
  s.add_dependency 'neat'
  s.add_dependency 'non-stupid-digest-assets'
  s.add_dependency 'normalize-rails'
  s.add_dependency 'paperclip'
  s.add_dependency 'pg'
  s.add_dependency 'pickadate-rails'
  s.add_dependency 'rails-settings-cached'
  s.add_dependency 'react-rails'
  s.add_dependency 'sass-rails'
  s.add_dependency 'sprockets'
  s.add_dependency 'sprockets-es6'
  s.add_dependency 'uuidtools'
  s.add_dependency 'will_paginate'

  # using a Rails 5 compatible versions of the following for now. See Gemfile
  # s.add_dependency 'draper'
end
