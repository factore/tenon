module Tenon
  class FormBuilder < ActionView::Helpers::FormBuilder
    include ActionView::Helpers::TagHelper
    attr_accessor :output_buffer
    alias_method :super_label, :label

    def tenon_content(method_name)
      @template.render 'tenon/tenon_content/builder',
        f: self,
        field: method_name
    end

    def asset(method_name, opts = {})
      defaults = {
        label: nil,
        wrapper_class: 'panel',
        # Remove button triggers cocoon's remove child event?
        remove_association: false
      }
      opts = defaults.merge(opts)
      @template.render 'tenon/fields/asset',
        f: self,
        label_tag: label(method_name, opts[:label]),
        method_name: method_name,
        proxy_attachment: object.send(method_name),
        opts: opts
    end

    def rich_text(method_name, opts = {})
      defaults = {
        placeholder: '--'
      }
      opts = defaults.merge(opts)

      @template.render 'tenon/fields/rich_text',
        f: self,
        method_name: method_name,
        label_tag: label(method_name, opts[:label]),
        opts: opts
    end
    alias_method :me_text, :rich_text

    alias_method :super_text_field, :text_field
    def text_field(method_name, opts = {})
      defaults = {
        placeholder: '--'
      }
      opts = defaults.merge(opts)

      @template.render 'tenon/fields/text_field',
        f: self,
        method_name: method_name,
        opts: opts
    end

    def title_text_field(method_name, opts = {})
      defaults = {
        placeholder: '--'
      }
      opts = defaults.merge(opts)

      @template.render 'tenon/fields/title_text_field',
        f: self,
        method_name: method_name,
        opts: opts
    end

    alias_method :super_email_field, :email_field
    def email_field(method_name, opts = {})
      defaults = {
        placeholder: '--'
      }
      opts = defaults.merge(opts)

      @template.render 'tenon/fields/email_field',
        f: self,
        method_name: method_name,
        opts: opts
    end

    alias_method :super_password_field, :password_field
    def password_field(method_name, opts = {})
      defaults = {
        placeholder: '--'
      }
      opts = defaults.merge(opts)

      @template.render 'tenon/fields/password_field',
        f: self,
        method_name: method_name,
        opts: opts
    end

    alias_method :super_number_field, :number_field
    def number_field(method_name, opts = {})
      defaults = {
        placeholder: '--'
      }
      opts = defaults.merge(opts)

      @template.render 'tenon/fields/number_field',
        f: self,
        method_name: method_name,
        opts: opts
    end

    alias_method :super_phone_field, :phone_field
    def phone_field(method_name, opts = {})
      defaults = {
        placeholder: '--'
      }
      opts = defaults.merge(opts)

      @template.render 'tenon/fields/phone_field',
        f: self,
        method_name: method_name,
        opts: opts
    end

    alias_method :super_url_field, :url_field
    def url_field(method_name, opts = {})
      defaults = {
        placeholder: '--'
      }
      opts = defaults.merge(opts)

      @template.render 'tenon/fields/url_field',
        f: self,
        method_name: method_name,
        opts: opts
    end

    alias_method :super_color_field, :color_field
    def color_field(method_name, opts = {})
      defaults = {
        placeholder: '--'
      }
      opts = defaults.merge(opts)

      @template.render 'tenon/fields/color_field',
        f: self,
        method_name: method_name,
        opts: opts
    end

    alias_method :super_text_area, :text_area
    def text_area(method_name, opts = {})
      @template.render 'tenon/fields/text_area',
        f: self,
        method_name: method_name,
        opts: opts
    end

    alias_method :super_select, :select
    def select(method_name, choices, opts = {}, html_opts = {})
      @template.render 'tenon/fields/select',
        f: self,
        method_name: method_name,
        choices: choices,
        opts: opts,
        html_opts: html_opts
    end

    alias_method :super_check_box, :check_box
    def check_box(method_name, opts = {})
      @template.render 'tenon/fields/check_box',
        f: self,
        method_name: method_name,
        opts: opts
    end

    def inline_check_box(method_name, opts = {})
      @template.render 'tenon/fields/inline_check_box',
        f: self,
        method_name: method_name,
        opts: opts
    end

    alias_method :super_radio_button, :radio_button
    def radio_button(method_name, value, opts = {})
      @template.render 'tenon/fields/radio_button',
        f: self,
        method_name: method_name,
        value: value,
        opts: opts
    end

    def inline_radio_button(method_name, value, opts = {})
      @template.render 'tenon/fields/inline_radio_button',
      f: self,
      method_name: method_name,
      value: value,
      opts: opts
    end

    alias_method :super_collection_select, :collection_select
    def collection_select(method_name, collection, value_method, text_method, opts = {}, html_opts = {})
      @template.render 'tenon/fields/collection_select',
        f: self,
        method_name: method_name,
        collection: collection,
        value_method: value_method,
        text_method: text_method,
        opts: opts,
        html_opts: html_opts
    end

    def date_picker(method_name, opts = {})
      @template.render 'tenon/fields/date_picker',
        f: self,
        method_name: method_name,
        opts: opts
    end

    def date_time_picker(method_name, opts = {})
      @template.render 'tenon/fields/date_time_picker',
        f: self,
        method_name: method_name,
        opts: opts
    end

    def text_area_content(method_name, options = {}, language = nil, language_title = nil)
      label = label(method_name, options[:label], language, language_title)
      explanation = explanation(options[:explanation])
      label + explanation + super_text_area(get_method(method_name, language), options)
    end

    def datetime_widget(method_name, options = {})
      label = label(method_name, options[:label], nil, nil)
      explanation = explanation(options[:explanation])

      on = content_tag(:tr) do
        [
          content_tag(:td, 'On: '),
          content_tag(:td, super_text_field("#{method_name}_date", class: 'datepicker', size: 12, value: @object.send(method_name) ? @object.send(method_name).strftime('%Y-%m-%d') : (options[:default_date] || Time.now.strftime('%Y-%m-%d'))))
        ].join('\n').html_safe
      end
      at = content_tag(:tr) do
        [
          content_tag(:td, 'At: '),
          content_tag(:td, super_text_field("#{method_name}_time", value: @object.send(method_name) ? @object.send(method_name).strftime('%l:%M%p').strip : (options[:default_time] || Time.now.strftime('%l:%M%p').strip), size: 7))
        ].join('\n').html_safe
      end
      table = content_tag(:table, on + at, class: 'datetime_select')

      content = label(method_name, options[:label], nil, nil)
      content += explanation(options[:explanation])
      content += content_tag(:div, table, class: 'inset datetime-widget')
    end

    def nested_fields(object, params = {})
      fields_for object.to_s.pluralize do |nf|
        @template.render "#{object}_fields", { f: nf }.merge(params)
      end
    end

    def label(method_name, label, required = false, inline = false, language = nil, language_title = nil)
      if label == false
        ''.html_safe
      else
        label ||= method_name.to_s.titleize
        label = language_title ? label + " (#{language_title.to_s.titleize})" : label
        label_class = ['input-block__label']
        label_class = ['input-block__label--inline'] if inline
        label_class << ' input-block__label--is-required' if required
        super(get_method(method_name, language), label.html_safe, class: label_class.join(' '))
      end
    end

    private

    def build_content(generator, method_name, options)
      content = send(generator, method_name, options)
      if Tenon::I18nLookup.new(@object.class).fields.include? method_name.to_s
        content = internationalize_content(generator, method_name, content, options)
      end
      content_tag(:div, content, class: 'form-field')
    end

    def internationalize_content(generator, method_name, content, options = {})
      if Tenon.config.languages
        content = content_tag(:div, content, class: 'i18n en active')
        Tenon.config.languages.each do |lang_title, lang|
          content += content_tag(:div, send(generator, method_name, options, lang, lang_title), class: "i18n #{lang}")
        end
        content = framed_content(content, options)
      else
        content
      end
    end

    def explanation(explanation)
      explanation ? content_tag(:div, explanation.html_safe, class: 'explanation') : ''
    end

    def get_method(method, language = nil)
      language ? "#{method}_#{language}" : method
    end

    def framed_content(content, options = {})
      content_tag :div, class: 'i18n-holder', style: ('display: inline-block;' if options[:inline]) do
        content_tag :div, content, class: 'i18n-frame'
      end
    end
  end
end
