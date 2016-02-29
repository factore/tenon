module Tenon
  module IconHelper
    def i(icon, opts = {})
      content_tag(:i, icon, class: "material-icon #{opts[:class] if opts[:class].present?}")
    end
  end
end
