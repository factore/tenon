ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../dummy/config/environment.rb',  __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'factory_girl_rails'
require 'capybara-webkit'
require 'database_cleaner'
require 'launchy'

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Load the factories from lib
FactoryGirl.definition_file_paths += %W(lib/tenon/factories)
FactoryGirl.reload

ActiveRecord::Migration.maintain_test_schema! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  config.include Tenon::Engine.routes.url_helpers
  config.include FactoryGirl::Syntax::Methods
  config.mock_with :rspec
  config.use_transactional_fixtures = false
  config.fixture_path = "#{File.dirname(__FILE__)}/fixtures"
  config.infer_base_class_for_anonymous_controllers = false
  config.order = 'random'
  config.backtrace_exclusion_patterns = [
    /\/lib\d*\/ruby\//,
    /bin\//,
    # /gems/,
    /spec\/spec_helper\.rb/,
    /lib\/rspec\/(core|expectations|matchers|mocks)/
  ]

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.after do
    if example.metadata[:type] == :feature and example.exception.present?
      save_and_open_page
    end
  end
end

Capybara.register_driver :quiet_webkit do |app|
  Capybara::Webkit::Driver.new(app, stderr: HushLittleWebkit.new)
end

Capybara.javascript_driver = :quiet_webkit

class HushLittleWebkit
  IGNOREABLE = /CoreText performance|userSpaceScaleFactor/

  def write(message)
    if message =~ IGNOREABLE
      0
    else
      puts(message)
      1
    end
  end
end
