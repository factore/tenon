module Tenon
  module FlashHelper
    def flash_messages
      messages = []
      %w(notice alert warning error).each do |msg|
        unless flash[msg.to_sym].blank?
          content = content_tag(:div, flash[msg.to_sym], class: 'flash__message')
          messages << content_tag(:div, content, class: "flash flash--#{msg}")
        end
      end
      messages.join('').html_safe
    end
  end
end
