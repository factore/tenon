ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../test/dummy/config/environment.rb',  __FILE__)
ActiveRecord::Migrator.migrations_paths = [File.expand_path("../../test/dummy/db/migrate", __FILE__)]
ActiveRecord::Migrator.migrations_paths << File.expand_path('../../db/migrate', __FILE__)
require 'rails/test_help'
require 'mocha/mini_test'
require 'rails-controller-testing'

# Improved Minitest output (color and progress bar)
require 'minitest/reporters'
Minitest::Reporters.use!(
  Minitest::Reporters::ProgressReporter.new,
  ENV,
  Minitest.backtrace_filter
)

# Capybara and poltergeist integration
# require 'capybara/rails'
# Capybara.javascript_driver = :poltergeist

class ActiveSupport::TestCase
  fixtures :all
end

class ActionController::TestCase
  include Devise::TestHelpers
end

ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)

# class ActionDispatch::IntegrationTest
#   include Capybara::DSL
# end

# See: https://gist.github.com/mperham/3049152
class ActiveRecord::Base
  mattr_accessor :shared_connection
  @@shared_connection = nil

  def self.connection
    @@shared_connection || ConnectionPool::Wrapper.new(:size => 1) do
      retrieve_connection
    end
  end
end
ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection
