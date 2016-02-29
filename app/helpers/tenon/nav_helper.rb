module Tenon
  module NavHelper
    def nav_item(text, path, icon, link_opts = {}, &blk)
      content = link(text, path, icon, link_opts)
      content += subnav(&blk) if block_given?
      content_tag(:li, content, class: "main-nav__item #{active_class(path, link_opts[:active])}")
    end

    private

    def subnav(&blk)
      icons = content_tag(:i, 'add', class: 'main-nav__open-icon')
      icons += content_tag(:i, 'remove', class: 'main-nav__close-icon')
      content = link_to(icons, '#', class: 'main-nav__link-toggle')
      content += content_tag(:ul, capture(&blk), class: 'main-nav__sub-nav')
      content
    end

    def link(text, path, icon, opts = {})
      content = content_tag(:i, icon, class: 'material-icon')
      content += content_tag(:span, text)
      opts[:class] ||= 'main-nav__link action-icon'
      opts[:class] += ' main-nav__link--sub' if opts[:sub]
      opts[:title] ||= text
      link_to(content, path, opts)
    end

    def active_class(path, active)
      path = url_for(path).split('/')[0..2].join('/')[1..-1]
      tenon_path = tenon.root_path.gsub(%r{^\/}, '') + controller_name
      if active || path == tenon_path
        'main-nav__item--active main-nav__item--open'
      else
        ''
      end
    end
  end
end
