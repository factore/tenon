module Tenon
  module IconHelper
    def i(icon)
      content_tag(:i, icon, class: 'material-icons')
    end
  end
end
