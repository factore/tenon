require 'spec_helper'

describe Tenon::Gallery do
  describe '.find_with_photos' do
    it "should find a gallery, include the photos, and order them by their list order" do
      expect(Tenon::Gallery).to receive(:includes).with(:photos) { Tenon::Gallery }
      expect(Tenon::Gallery).to receive(:order).with('tenon_photos.list_order') { Tenon::Gallery }
      expect(Tenon::Gallery).to receive(:find).with(1)
      Tenon::Gallery.find_with_photos(1)
    end
  end
end
