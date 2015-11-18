class CommentMailer < ActionMailer::Base
  # TODO: Find a better way to set the host
  # default_url_options[:host] = MySettings.site_url ? MySettings.site_url.gsub('http://', '') : 'localhost:3000'

  def comment_notification(email, comment)
    @post = comment.commentable
    @comment = comment
    mail(
      to: email,
      subject: "#{MySettings.site_name} - New Comment: #{@post.title}",
      from: MySettings.from_email
    )
  end
end
