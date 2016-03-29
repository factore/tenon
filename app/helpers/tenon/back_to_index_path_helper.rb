module Tenon
  # Generate a back button that includes the previous query if there was one
  module BackToIndexPathHelper
    def back_to_index_path(obj)
      path = polymorphic_path(obj.class)
      if cookies["last-query-#{path}.json"].present?
        query = JSON.parse(cookies["last-query-#{path}.json"])
        path = polymorphic_path(obj.class, query)
      end
      path
    end
  end
end
