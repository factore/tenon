module Tenon
  module InputBlockHelper
    def input_block(label, opts = {}, &blk)
      content_tag :div, class: 'input-block' do
        block_label_tag(label) +
        content_tag(:div, capture(&blk), class: 'input-block__inline-group' ) +
        block_explanation(opts[:explanation])
      end
    end

    private

    def block_label_tag(text)
      content_tag(:label, text, class: 'input-block__label')
    end

    def block_explanation(text)
      if text.present?
        return content_tag(:div, text, class: 'input-block__explanation')
      else
        return ''
      end
    end
  end
end
