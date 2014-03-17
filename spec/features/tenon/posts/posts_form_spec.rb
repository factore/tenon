require 'spec_helper'
include RequestHelpers

describe 'Using the post form', js: true do
  let!(:admin) { create(:admin) }

  before do
    login(admin)
  end

  context 'when doing everything right' do
    it "should save the post" do
      visit new_post_path
      within('form#new_post') do
        fill_in "post[title]", with: "My Test Post"
        click_on "Save"
      end
      expect(page).to have_content('My Test Post')
      expect(page).to have_content('Post saved successfully.')
    end
  end

  context 'when doing something wrong' do
    it "should not save the page" do
      visit new_post_path
      within('form#new_post') do
        click_on "Save"
      end
      expect(page).to have_content("Title can't be blank")
    end
  end
end