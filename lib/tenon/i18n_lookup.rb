module Tenon
  class I18nLookup
    def initialize(klass)
      @klass = klass
    end

    def fields
      self.class.fields[:tables][@klass.to_s.underscore.pluralize.to_sym] || []
    end

    def self.fields
      @@fields ||= YAML.load(config_file).recursive_symbolize_keys!
    end

    private

    def self.config_file
      File.open(File.join(Rails.root, 'config/i18n_fields.yml'))
    end
  end
end