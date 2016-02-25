module Tenon
  module ActiveLinkToHelper
    def active_link_to(name = nil, options = {}, html_options = nil, &block)
      options[:class] = '' unless options[:class].present?
      options[:class] += ' --is-active' if name == request.original_fullpath
      link_to(name, options, html_options, &block)
    end
  end
end
