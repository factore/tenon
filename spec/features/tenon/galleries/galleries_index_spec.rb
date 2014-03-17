require 'spec_helper'
include RequestHelpers

describe 'Viewing the list of galleries', js: true do
  let!(:admin) { create(:admin) }

  before do
    login(admin)
  end

  context 'when there is a gallery' do
    let!(:gallery) { create(:gallery) }


    it "should see the gallery in a list" do
      visit galleries_path
      expect(page).to have_content(gallery.title)
    end

    it "should delete the gallery" do
      visit galleries_path
      within 'ul#galleries' do
        click_on 'Delete'
      end
      expect(page).not_to have_content(gallery.title)
    end
  end
end