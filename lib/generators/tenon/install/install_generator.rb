module Tenon
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../../../../../', __FILE__)

      def copy_files
        copy_file('config/initializers/tenon.rb', File.join(Rails.root, 'config', 'initializers', 'tenon.rb'))
        copy_file('app/views/tenon/shared/_main_nav.html.haml', File.join(Rails.root, 'app', 'views', 'tenon', 'shared', '_main_nav.html.haml'))
        copy_file('app/assets/stylesheets/tenon/colors-custom.css.scss', File.join(Rails.root, 'app', 'assets', 'stylesheets', 'tenon', 'colors-custom.css.scss'))
        copy_file('lib/generators/tenon/install/tenon_addons.js', File.join(Rails.root, 'app', 'assets', 'javascripts', 'tenon_addons.js'))
        FileUtils.mkdir_p(File.join(Rails.root, 'app', 'assets', 'javascripts', 'tenon_addons'))

        puts ''
        puts 'Make sure you add the following lines of code: '
        puts '  config/application.rb: require "active_record/railtie"'
        puts '  app/controllers/application_controller.rb: helper Tenon::Engine.helpers'
      end
    end
  end
end
