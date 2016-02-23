module Tenon
  module FlashHelper
    def flash_messages
      close_icon = content_tag(:i, 'close', class: 'material-icon')
      messages = []
      %w(notice alert warning error).each do |msg|
        unless flash[msg.to_sym].blank?
          content = content_tag(:p, flash[msg.to_sym])
          content += link_to close_icon, '#', class: 'flash__dismiss action-icon'
          messages << content_tag(:div, content, class: "flash flash--#{msg}")
        end
      end
      messages.join('').html_safe
    end
  end
end
