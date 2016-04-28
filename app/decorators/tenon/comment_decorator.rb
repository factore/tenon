module Tenon
  class CommentDecorator < ApplicationDecorator
    def email
      @object.author_email
    end

    def author_url
      url = @object.author_url
      if url.blank? || url.match('http://') || url.match('https://')
        url
      else
        'http://' + url
      end
    end

    def error_message
      errors = []
      @object.errors.full_messages.each { |error| errors << "<li>#{error}</li>" }
      "<div class='error-explanation' id='error-explanation'>#{I18n.t('tenon.common.there_were_problems_with_the_following_fields')}:<ul>#{errors.join('')}<ul></div>"
    end
  end
end
