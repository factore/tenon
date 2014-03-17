module Tenon
  class MySettings < RailsSettings::Settings
    self.table_name = 'settings'
    def self.full_url
      if self.site_url.match(/https?:\/\//)
        self.site_url
      else
        "http://#{self.site_url}"
      end
    end
  end
end
