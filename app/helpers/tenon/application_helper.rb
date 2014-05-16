module Tenon
  module ApplicationHelper
    def flash_messages
      messages = []
      %w(notice alert warning error).each do |msg|
        unless flash[msg.to_sym].blank?
          content = content_tag(:p, flash[msg.to_sym])
          content += link_to fa_icon('times'), '#', id: 'flash-dismiss'
          messages << content_tag(:div, content, class: "flash flash-#{msg}")
        end
      end
      messages.join('').html_safe
    end

    def menu_item(title, link, options = {})
      klass = ''
      # set the link class to active if it matches the current link or any of the alternate supplied links
      options[:alt_links].each { |a| klass = request.fullpath.match(a) ? 'active' : '' unless klass == 'active' } if options[:alt_links].is_a?(Array)
      klass = 'active' if link == request.fullpath
      klass += " #{options[:class]}" unless options[:class].blank?
      link_to(title, link, class: klass)
    end

    # now uses http://github.com/mdeering/gravatar_image_tag
    def gravatar_for(object)
      gravatar_image_tag(object.email)
    end

    def table_row(*args)
      html = '<tr>'
      args.each_with_index do |cell, i|
        html += "<td class='cell-#{i + 1}'>#{cell}</td>"
      end
      html += '</tr>\n'

      html.html_safe
    end

    def seo_meta_tags
      obj = instance_variable_get("@#{params[:controller].singularize}")
      tags = []
      if obj
        if obj.respond_to?(:seo_keywords) && !obj.seo_keywords.blank?
          tags << tag(:meta,  name: 'keywords', content: obj.seo_keywords)
        end
        if obj.respond_to?(:seo_description) && !obj.seo_description.blank?
          tags << tag(:meta,  name: 'description', content: obj.seo_description)
        end
      end
      tags.join
    end

    # eg. first_image(@product)
    def first_image(obj, options = {})
      opts = {
        collection: :images,
        method: :image,
        style: :thumbnail,
        default: image_path('noimage.jpg')
      }.merge(options.symbolize_keys!)

      image = obj.send(opts[:collection]).first
      image ? image.send(opts[:method]).url(opts[:style]) : opts[:default]
    end

    def html(options = {}, &blk)
      options.recursive_symbolize_keys!

      open = h5bp_opening_tag(options[:ie_versions])
      body = capture_haml(&blk)
      close = '</html>'.html_safe

      open + body + close
    end

    def route_exist?(thing)
      main_app.polymorphic_path(thing)
    rescue NoMethodError
      false
    end

    private

    def h5bp_opening_tag(ie_versions = 6..8)
      ie_versions = ie_versions.to_a

      htmls = []
      max = ie_versions.max

      # individual IE versions
      ie_versions.each do |version|
        next if version == max

        klass = ie_versions.select { |e| e > version }.map { |e| "ie-lt#{e}" }.join(' ')

        htmls << if_ie("<html lang='#{I18n.locale}' dir='ltr' class='noscript #{klass}'>", version: version)
      end

      # trailing GT for forward compatibility
      htmls << if_ie("<html lang='#{I18n.locale}' dir='ltr' class='noscript'>", version: ">=#{max}", show_in_other_browsers: true)
      htmls.join($INPUT_RECORD_SEPARATOR).html_safe
    end

    def if_ie(obj, options = {})
      options.recursive_symbolize_keys!

      # grab the kwargs
      version = options[:version]
      negative = options[:negative]
      show_in_other_browsers = options[:show_in_other_browsers]

      # support things like >10
      if version.respond_to?(:start_with?) && version.respond_to?(:scan)
        modifier =  if version.start_with?('>=')
                      'gte'
                    elsif version.start_with?('<=')
                      'lte'
                    elsif version.start_with?('<')
                      'lt'
                    elsif version.start_with?('>')
                      'gt'
                    end

        version = version.scan(/\d/).join.to_i
      end

      selector = "#{negative && '!'}(#{modifier} IE #{version})"

      if show_in_other_browsers
        "<!--[if #{selector}]> -->#{obj}<!-- <![endif]-->"
      else
        "<!--[if #{selector}]>#{obj}<![endif]-->"
      end
    end

      # humanizing various things
    def human(object)
      if object.is_a?(Date)
        object.strftime('%B %d, %Y')
      elsif object.is_a?(Time)
        object.strftime('%B %d, %Y at %I:%M %p')
      elsif object.is_a?(String)
        object.humanize
      else
        object
      end
    end
  end
end
