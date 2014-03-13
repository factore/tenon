require 'spec_helper'

describe Gallery do
  describe '.find_with_photos' do
    it "should find a gallery, include the photos, and order them by their list order" do
      expect(Gallery).to receive(:includes).with(:photos) { Gallery }
      expect(Gallery).to receive(:order).with('photos.list_order') { Gallery }
      expect(Gallery).to receive(:find).with(1)
      Gallery.find_with_photos(1)
    end
  end
end
