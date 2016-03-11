# Helpful serializer for including pagination meta
# Source: http://stackoverflow.com/a/23002614/131208
module Tenon
  class PaginatingSerializer < ActiveModel::ArraySerializer
    def initialize(object, options = {})
      meta_key = options[:meta_key] || :meta
      options[meta_key] ||= {}
      options[meta_key][:pagination] = {
        current_page: object.current_page,
        per_page: object.per_page,
        offset: object.offset,
        total_pages: object.total_pages,
        total_entries: object.total_entries
      }
      super(object, options)
    end
  end
end
