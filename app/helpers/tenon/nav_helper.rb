module Tenon
  module NavHelper
    def nav_item(text, path, icon, link_opts = {}, &blk)
      content = link(text, path, icon, link_opts)
      content += subnav(&blk) if block_given?
      content_tag(:li, content, class: "main-nav__item #{active_class(path, link_opts[:active])}")
    end

    private

    def subnav(&blk)
      icons = content_tag(:i, 'add', class: 'main-nav__open-icon material-icon')
      icons += content_tag(:i, 'remove', class: 'main-nav__close-icon material-icon')
      content = link_to(icons, '#', class: 'main-nav__link-toggle action-icon')
      content += content_tag(:ul, capture(&blk), class: 'main-nav__sub-nav')
      content
    end

    def link(text, path, icon, opts = {})
      content = content_tag(:i, icon, class: 'material-icon')
      content += content_tag(:span, text)
      opts[:class] ||= 'main-nav__link action-icon'
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
