module Tenon
  class PageDecorator < ApplicationDecorator
    def option_title
      ot = ''
      ot << '&nbsp;' * ((@object.depth || 0) * 3)
      ot << '- ' if (@object.depth || 0) > 0
      ot << @object.title
      ot.html_safe
    end
  end
end
