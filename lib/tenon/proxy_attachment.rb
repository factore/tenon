module Tenon
  class ProxyAttachment
    attr_reader :attachment

    def initialize(attachment, klass, asset_name)
      @attachment = attachment.try(:attachment) || attachment
      @style_prefix = "#{klass.to_s.underscore}_#{asset_name}"
    end

    def original_filename
      @attachment.original_filename
    end

    def display_name
      Tenon::AssetDecorator.new(@attachment.instance).display_name
    end

    def url(style = :_original, *args)
      # Prefix with an underscore to use base Asset styles
      if style.match(/^_.*/)
        new_style = style.to_s.gsub(/^_(.*)/, '\1')
        @attachment.url(new_style, *args)
      else
        @attachment.url("#{@style_prefix}_#{style}", *args)
      end
    end
  end
end
