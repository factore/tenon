module Tenon
  module Generators
    class I18nMigrationsGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      def copy_files
        timestamp = Time.now.strftime('%Y%m%d%H%M%S')
        template('migration.rb', File.join('db/migrate', "#{timestamp}_add_i18n_fields_#{file_hash.capitalize}.rb"))
      end

      private

      def yaml
        @yaml ||= YAML.load_file(File.join(Rails.root, 'config', 'i18n_fields.yml')).symbolize_keys
      end

      def languages
        Tenon.config.languages.values
      end

      def tables
        yaml[:tables]
      end

      def file_hash
        require 'digest/md5'
        Digest::MD5.hexdigest(yaml.to_s)
      end
    end
  end
end
