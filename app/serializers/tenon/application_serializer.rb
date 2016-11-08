module Tenon
  # Some basic functionality that most resources will want
  class ApplicationSerializer < ActiveModel::Serializer
    def formatted_publish_at
      if object.publish_at.present?
        object.publish_at.strftime('%B %e, %Y at %-l:%m%p')
      end
    end

    def to_param
      object.to_param
    end

    def resource_type
      klass = object.object ? object.object.class : object.class
      klass.to_s.underscore
    end

    def attributes(*args)
      super.merge(default_attributes)
    end

    private

    def default_attributes
      {
        id: object.id,
        title: object.title,
        to_param: object.to_param,
        resource_type: resource_type,
        edit_path: view_context.polymorphic_path([:edit, object]),
        update_path: view_context.polymorphic_path(object),
        destroy_path: view_context.polymorphic_path(object)
      }
    end
  end
end
