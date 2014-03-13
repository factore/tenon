require 'spec_helper'

describe MySettings do
  describe ".full_url" do
    ['http://', 'https://'].each do |protocol|
      context "when the URL starts with #{protocol}" do
        before do
          MySettings.site_url = "#{protocol}www.factore.ca"
        end

        it "should just give us the site_url" do
          expect(MySettings.full_url).to eq(MySettings.site_url)
        end
      end
    end

    context "when the URL is not preceded by a protocol" do
      before do
        MySettings.site_url = 'www.factore.ca'
      end

      it "should prepend 'http://' to the site_url" do
        expect(MySettings.full_url).to eq("http://#{MySettings.site_url}")
      end
    end
  end
end
