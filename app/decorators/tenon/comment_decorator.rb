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
      "<div class='errorExplanation' id='errorExplanation'>There were problems with the following fields:<ul>#{errors.join('')}<ul></div>"
    end
  end
end