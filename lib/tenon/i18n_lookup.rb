module Tenon
  class I18nLookup
    def initialize(klass)
      @klass = klass.to_s.sub /Decorator\z/, ''
    end

    def fields
      self.class.fields[:tables][@klass.underscore.pluralize.to_sym] || []
    end

    def self.fields
      @@fields ||= set_fields
    end

    def self.set_fields
      default = { tables: {} }
      if File.exist?(config_file)
        result = YAML.load(File.open(config_file)).recursive_symbolize_keys!
        result || default
      else
        default
      end
    end

    def self.config_file
      File.join(Rails.root, 'config/i18n_fields.yml')
    end
  end
end
