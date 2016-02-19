module Tenon
  class ContactDecorator < ApplicationDecorator
    def sent_date
      "#{@object.created_at.strftime('%B %e, %Y')} #{I18n.t('tenon.common.at')} #{@object.created_at.strftime('%l:%M %p')}"
    end

    def error_message
      errors = []
      @object.errors.full_messages.each { |error| errors << "<li>#{error}</li>" }
      "<div class='error-explanation' id='error-explanation'>#{I18n.t('tenon.common.there_were_problems_with_the_following_fields')}:<ul>#{errors.join('')}<ul></div>"
    end
  end
end
