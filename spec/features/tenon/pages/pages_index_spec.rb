require 'spec_helper'
include RequestHelpers

describe 'Viewing the list of pages', js: true do
  let!(:admin) { create(:admin) }

  before do
    login(admin)
  end

  context 'when there is a page' do
    let!(:page_obj) { create(:page) }


    it "should see the page in a list" do
      visit pages_path
      expect(page).to have_content(page_obj.title)
    end

    it "should delete the page" do
      visit pages_path
      click_on 'Delete'
      expect(page).not_to have_content(page_obj.title)
    end
  end

  context 'when there is a page and a subpage' do
    let!(:page_obj) { create(:page) }
    let!(:subpage) { create(:page, parent: page_obj) }

    it "should see the subpage nested under the page" do
      visit pages_path
      within("li[data-record-id='#{page_obj.id}'] > ul") do
        expect(page).to have_content(subpage.title)
      end
    end

    it "should delete the subpage" do
      visit pages_path
      within("li[data-record-id='#{page_obj.id}'] > ul") do
        click_on 'Delete'
        expect(page).not_to have_content(subpage.title)
      end
    end
  end
end