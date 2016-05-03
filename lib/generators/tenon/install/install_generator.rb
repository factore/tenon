module Tenon
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../../../../../', __FILE__)

      def copy_files
        copy_file('config/initializers/tenon.rb', File.join(Rails.root, 'config', 'initializers', 'tenon.rb'))
        copy_file('app/views/tenon/shared/_main_nav.html.haml', File.join(Rails.root, 'app', 'views', 'tenon', 'shared', '_main_nav.html.haml'))
        directory('lib/ckeditor', Rails.root.join('public', 'ckeditor'))

        puts ''
        puts 'Make sure you add the following lines of code: '
        puts '  config/application.rb: require "active_record/railtie"'
        puts '  app/controllers/application_controller.rb: helper Tenon::Engine.helpers'
      end
    end
  end
end
