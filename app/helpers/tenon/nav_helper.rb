module Tenon
  module NavHelper
    def nav_item(text, path_object, icon_class, link_opts = {})
      path = path(path_object)
      content = link(text, path, icon_class, link_opts)
      content_tag(:li, content)
    end

    private

    def path(path_object)
      if path_object.is_a?(Class)
        path_object
      else
        path_object
      end
    end

    def link(text, path, icon_class, opts = {})
      content = content_tag(:i, '', class: "fa fa-#{icon_class} fa-fw")
      content += text
      opts[:class] ||= ''
      opts[:title] ||= text
      opts[:class] += " #{active_class(path, opts[:active])}"
      link_to(content, path, opts)
    end

    def active_class(path, active)
      path = url_for(path).split('/')[0..2].join('/')[1..-1]
      tenon_path = tenon.root_path.gsub(/^\//,'') + controller_name
      'active' if active || path == tenon_path
    end
  end
end
