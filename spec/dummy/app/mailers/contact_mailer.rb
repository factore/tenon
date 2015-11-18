class ContactMailer < ActionMailer::Base
  # TODO: Find a better way to set the host
  # default_url_options[:host] = MySettings.site_url ? MySettings.site_url.gsub('http://', '') : 'localhost:3000'

  def contact_notification(contact)
    @contact = contact
    mail(
      to: MySettings.contact_email,
      subject: "#{MySettings.site_name} - New Contact Request",
      from: @contact.email
    )
  end
end
