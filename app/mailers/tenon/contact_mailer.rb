module Tenon
  class ContactMailer < ActionMailer::Base
    # TODO: Find a better way to set the host
    # default_url_options[:host] = MySettings.site_url ? MySettings.site_url.gsub('http://', '') : 'localhost:3000'

    def contact_notification(email, contact)
      @contact = contact
      mail(
        to: email,
        subject: "#{Tenon::MySettings.site_name} - New Contact Request",
        from: Tenon::MySettings.from_email
      )
    end
  end
end
