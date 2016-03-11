module Tenon
  class ApplicationDecorator < Draper::Decorator
    delegate_all

    def serializer_class
      "#{object.class}Serializer".safe_constantize
    end

    def path
      h.url_for(object)
    end

    def edit_path
      h.url_for([:edit, object])
    end

    def edit_link(opts = {})
      h.edit_link(object, opts)
    end

    def delete_link(opts = {})
      h.delete_link(object, opts)
    end

    def published?
      if object.try(:publish_at)
        object.publish_at <= Time.now
      elsif object.respond_to?(:published)
        object.published
      else
        true
      end
    end
  end
end
