module Tenon
  module BreadcrumbsHelper
    def breadcrumb_links
      links = [make_link('Tenon', root_path)]
      if controller_name != 'index'
        path = polymorphic_path(controller_name)
        links << make_link(controller_name.titleize, path)

        if %w( new edit ).include?(action_name)
          links << make_link(member_title, member_path)
        end
      end
      links
    end

    private

    def make_link(title, path)
      {
        title: title,
        path: path
      }
    end

    def member_path
      request.path
    end

    def member_title
      title = action_name.titleize + ' '
      singular = controller_name.singularize
      instance = instance_variable_get("@#{singular}")
      if instance && instance.try(:title).present?
        title += instance.title.titleize
      else
        title += singular.titleize
      end
      title
    end
  end
end
