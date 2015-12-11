module Tenon
  module NavHelper
    def nav_item(text, path, icon_class, link_opts = {}, &blk)
      content = link(text, path, icon_class, link_opts)
      content += subnav(&blk) if block_given?
      content_tag(:li, content, class: active_class(path, link_opts[:active]))
    end

    private

    def subnav(&blk)
      icon = content_tag(:i, nil, class: 'icon ion-android-add')
      content = link_to(icon, '#', class: 'nav-item-toggle')
      content += content_tag(:ul, capture(&blk))
      content
    end

    def link(text, path, icon_class, opts = {})
      content = content_tag(:i, '', class: "icon ion-#{icon_class}")
      content += text
      opts[:class] ||= ''
      opts[:title] ||= text
      link_to(content, path, opts)
    end

    def active_class(path, active)
      path = url_for(path).split('/')[0..2].join('/')[1..-1]
      tenon_path = tenon.root_path.gsub(/^\//,'') + controller_name
      'active open' if active || path == tenon_path
    end
  end
end
