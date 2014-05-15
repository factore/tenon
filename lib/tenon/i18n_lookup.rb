module Tenon
  class I18nLookup
    def initialize(klass)
      @klass = klass
    end

    def fields
      self.class.fields[:tables][@klass.to_s.underscore.pluralize.to_sym] || []
    end

    def self.fields
      @@fields ||= set_fields
    end

    def self.set_fields
      if File.exist?(config_file)
        YAML.load(File.open(config_file)).recursive_symbolize_keys!
      else
        { tables: {} }
      end
    end

    def self.config_file
      File.join(Rails.root, 'config/i18n_fields.yml')
    end
  end
end
