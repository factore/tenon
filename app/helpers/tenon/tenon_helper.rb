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
      link_to(icon_tag, link, default_options.deep_merge(options))
    end

    # default tenon edit link
    def edit_link(obj, options = {})
      if can?(:edit, obj)
        url = polymorphic_url([:edit] + Array(obj))
        action_link('Edit', url, 'pencil', options)
      end
    end

    # default tenon delete link
    def delete_link(obj, options = {})
      if can?(:destroy, obj)
        default_options = { data: {
          confirm: 'Are you sure? There is no undo for this!',
          tooltip: 'Delete',
          method: 'Delete',
          remote: 'true'
        } }
        url = polymorphic_url(obj)
        action_link('Delete', url, 'trash-o', default_options.deep_merge(options))
      end
    end

    # browser detection and warning message
    def browser_detection(http)
      if http.match(/MSIE 6|MSIE 7|MSIE 8.0/)
        content_tag(:div, "For an optimal Tenon experience, please upgrade Internet Explorer to the #{link_to 'latest version', 'http://browsehappy.com/', target: '_blank'} or switch to another #{link_to 'modern browser', 'http://browsehappy.com/', target: '_blank'}.".html_safe, id: 'flash-warning', class: 'flash-msg')
      end
    end

    # form row helper for boolean published block
    def publish_box(f, object)
      if can?(:publish, object)
        content = [
          f.check_box(:published, class: 'tn-checkbox-right'),
          f.super_label(:published, 'Published?')
        ].join(' ').html_safe
        content_tag(:div, content, class: 'form-group inline')
      end
    end
  end
end
