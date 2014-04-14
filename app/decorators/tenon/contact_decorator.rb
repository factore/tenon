module Tenon
  class ContactDecorator < ApplicationDecorator
    def sent_date
      @object.created_at.strftime('%B %e, %Y at %l:%M %p')
    end

    def error_message
      errors = []
      @object.errors.full_messages.each { |error| errors << "<li>#{error}</li>" }
      "<div class='error-explanation' id='error-explanation'>There were problems with the following fields:<ul>#{errors.join('')}<ul></div>"
    end
  end
end
