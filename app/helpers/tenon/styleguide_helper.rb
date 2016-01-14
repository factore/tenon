module Tenon
  module StyleguideHelper
    def color_spans(arr, join = ', ')
      arr.map{|c| color_span(c)}.join(join).html_safe
    end

    def color_span(color)
      content_tag(:span, color, class: "color-#{color}")
    end
  end
end
