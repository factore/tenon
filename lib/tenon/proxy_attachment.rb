module Tenon
  class ProxyAttachment
    attr_reader :attachment

    def initialize(attachment, klass, asset_name)
      @attachment = attachment.try(:attachment) || attachment
      @style_prefix = "#{klass.to_s.underscore.gsub('/', '_')}_#{asset_name}"
    end

    def original_filename
      @attachment.original_filename
    end

    def display_name
      Tenon::AssetDecorator.new(@attachment.instance).display_name
    end

    # Prefix with an underscore to use base Asset styles
    def url(style = :original, *args)
      if style.to_sym == :original
        original_url(*args)
      else
        named_url(style, *args)
      end
    end

    private

    def original_url(*args)
      scoped_original = "#{@style_prefix}_original".to_sym
      styles = @attachment.styles.keys
      if styles.include?(scoped_original)
        @attachment.url(scoped_original, *args)
      else
        @attachment.url(:original, *args)
      end
    end

    def named_url(style, *args)
      if style.match(/^_.*/)
        @attachment.url(style.to_s.gsub(/^_(.*)/, '\1'), *args)
      else
        @attachment.url("#{@style_prefix}_#{style}", *args)
      end
    end
  end
end
