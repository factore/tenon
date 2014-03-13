require 'spec_helper'

describe Tenon::MySettings do
  describe ".full_url" do
    ['http://', 'https://'].each do |protocol|
      context "when the URL starts with #{protocol}" do
        before do
          Tenon::MySettings.site_url = "#{protocol}www.factore.ca"
        end

        it "should just give us the site_url" do
          expect(Tenon::MySettings.full_url).to eq(Tenon::MySettings.site_url)
        end
      end
    end

    context "when the URL is not preceded by a protocol" do
      before do
        Tenon::MySettings.site_url = 'www.factore.ca'
      end

      it "should prepend 'http://' to the site_url" do
        expect(Tenon::MySettings.full_url).to eq("http://#{Tenon::MySettings.site_url}")
      end
    end
  end
end
