module Tenon
  class CommentMailer < ActionMailer::Base
    default :from => MySettings.from_email
    default_url_options[:host] = MySettings.site_url ? MySettings.site_url.gsub('http://', '') : 'localhost:3000'

    def comment_notification(email, comment)
      @post = comment.commentable
      @comment = comment
      mail(:to => email, :subject => "#{MySettings.site_name} - New Comment: #{@post.title}")
    end
  end
end