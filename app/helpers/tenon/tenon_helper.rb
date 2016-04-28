module Tenon
  module TenonHelper
    def display_controller(controller)
      controller = controller.split('/')[1] if controller.match('/')
      controller.humanize.titleize
    end

    def display_action(action)
      action = 'edit' if action == 'update'
      action = 'new' if action == 'create'
      action.titleize.humanize
    end

    # default tenon action link
    def action_link(title, link, icon, options = {})
      icon_tag = content_tag(:i, '', class: "fa fa-#{icon} fa-fw")
      default_options = { title: title, data: { tooltip: title } }
      link_to icon_tag, link, default_options.deep_merge(options)
    end

    # extention of action_link for boolean toggles
    def toggle_link(object, field, link, true_values, false_values)
      state = object.send(field)
      icon = state ? true_values[0] : false_values[0]
      tooltip = state ? true_values[1] : false_values[1]
      data = {
        trueicon:     true_values[0],
        falseicon:    false_values[0],
        truetooltip:  true_values[1],
        falsetooltip: false_values[1]
      }
      action_link tooltip, link, icon, class: "toggle #{field} #{state}", data: data
    end

    # default tenon edit link
    def edit_link(obj, options = {})
      if can?(:edit, obj)
        url = polymorphic_url([:edit] + Array(obj))
        action_link(t('tenon.common.edit'), url, 'pencil', options)
      end
    end

    # default tenon delete link
    def delete_link(obj, options = {})
      if can?(:destroy, obj)
        default_options = { data: {
          confirm: t('tenon.common.are_you_sure'),
          tooltip: t('tenon.common.delete'),
          method: 'Delete',
          remote: 'true'
        } }
        url = polymorphic_url(obj)
        action_link(t('tenon.common.delete'), url, 'trash-o', default_options.deep_merge(options))
      end
    end

    # browser detection and warning message
    def browser_detection(http)
      # if http.match(/MSIE 6|MSIE 7|MSIE 8.0/)
        content_tag(:div, t('tenon.common.for_an_optimal_tenon_experience', latest_version: link_to('latest version', 'http://browsehappy.com/', target: '_blank'), modern_browser: link_to('modern browser', 'http://browsehappy.com/', target: '_blank')).html_safe, id: 'flash-warning', class: 'flash-msg')
      # end
    end

    def i18n_language_nav(table)
      if Tenon.config.languages && I18nLookup.fields[:tables][table]
        render 'tenon/shared/i18n_language_nav'
      end
    end
  end
end
