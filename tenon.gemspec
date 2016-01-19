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

  s.add_development_dependency 'better_errors'#, '2.1.0'
  s.add_development_dependency 'binding_of_caller'#, '0.7.2'
  s.add_development_dependency 'capybara'#, '2.5.0'
  s.add_development_dependency 'capybara-webkit'#, '1.7.1'
  s.add_development_dependency 'database_cleaner'#, '1.2.0'
  s.add_development_dependency 'factory_girl_rails'#, '4.4.1'
  s.add_development_dependency 'rspec-rails'#, '2.14.2'
  s.add_development_dependency 'spring'#, '1.1.3'
  s.add_development_dependency 'spring-commands-rspec'#, '1.0.2'
  s.add_development_dependency 'quiet_assets'

  s.add_dependency 'rails', '5.0.0.beta1'

  s.add_dependency 'awesome_nested_set'#, '3.0.0.rc.5'
  s.add_dependency 'aws-s3'#, '0.6.3'
  s.add_dependency 'aws-sdk'#, '1.8.1.3'
  s.add_dependency 'browserify-rails'
  s.add_dependency 'cancan'#, '1.6.10'
  s.add_dependency 'cocoon'#, '1.2.6'
  s.add_dependency 'coffee-rails'#, '4.1.0'
  s.add_dependency 'coffee-script-source'#, '1.9.1'
  s.add_dependency 'daemons'#, '1.1.9'
  s.add_dependency 'date_time_attribute'
  s.add_dependency 'dynamic_form'#, '1.1.4'
  s.add_dependency 'eco'#, '1.0.0'
  s.add_dependency 'font-awesome-rails'#, '>=4.0.3.1'
  s.add_dependency 'gravatar_image_tag'#, '1.1.3'
  s.add_dependency 'haml'#, '4.0.5'
  s.add_dependency 'hpricot'#, '0.8.6'
  s.add_dependency 'httparty'#, '0.10.2'
  s.add_dependency 'humanizer'#, '2.6.0'
  s.add_dependency 'ionicons-rails'
  s.add_dependency 'jbuilder'#, '2.0.7'
  s.add_dependency 'jquery-fileupload-rails'#, '0.4.1'
  s.add_dependency 'jquery-rails'#, '3.1.0'
  s.add_dependency 'jquery-ui-rails'#, '4.0.5'
  s.add_dependency 'later_dude'#, '0.3.3'
  s.add_dependency 'launchy'#, '2.4.2'
  s.add_dependency 'lodash-rails'#, '2.4.1'
  s.add_dependency 'mediaelement_rails'#, '0.4.0'
  s.add_dependency 'mime-types'#, '1.25.1'
  s.add_dependency 'neat'#, '1.6.0'
  s.add_dependency 'nokogiri'#, '>=1.5.11'
  s.add_dependency 'non-stupid-digest-assets'#, '1.0.4'
  s.add_dependency 'normalize-rails'#, '3.0.1'
  s.add_dependency 'paperclip'#, '4.1.1'
  s.add_dependency 'pickadate-rails'
  s.add_dependency 'pg'#, '>= 0.17.0'
  s.add_dependency 'rails-settings-cached'#, '0.4.1'
  s.add_dependency 'rdiscount'#, '2.0.7.3'
  s.add_dependency 'react-rails'
  s.add_dependency 'sass-rails'#, '5.0.3'
  s.add_dependency 'simple-rss'#, '1.2.3'
  s.add_dependency 'sprockets'#, '3.4.0'
  s.add_dependency 'sprockets-es6'
  s.add_dependency 'uglifier'#, '2.5.0'
  s.add_dependency 'uuidtools'#, '2.1.4'
  s.add_dependency 'will_paginate'#, '3.0.5'
  s.add_dependency 'yaml_db'#, '0.2.3'

  # using a Rails 5 compatible versions of the following for now. See Gemfile
  # s.add_dependency 'draper'#, '1.3.0'
end
