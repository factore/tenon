module Tenon
  module FlashHelper
    def flash_messages
      messages = []
      %w(notice alert warning error).each do |msg|
        unless flash[msg.to_sym].blank?
          content = content_tag(:p, flash[msg.to_sym])
          content += link_to fa_icon('times'), '#', id: 'flash-dismiss'
          messages << content_tag(:div, content, class: "flash flash-#{msg}")
        end
      end
      messages.join('').html_safe
    end
  end
end
