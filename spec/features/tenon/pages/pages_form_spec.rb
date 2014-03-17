require 'spec_helper'
include RequestHelpers

describe 'Using the page form', js: true do
  let!(:admin) { create(:admin) }

  before do
    login(admin)
  end

  context 'when doing everything right' do
    it 'should save the page' do
      visit new_page_path
      within('form#new_page') do
        fill_in 'page[title]', with: 'My Test Page'
        click_on 'Save'
      end
      expect(page).to have_content('My Test Page')
      expect(page).to have_content('Page saved successfully.')
    end
  end

  context 'when doing something wrong' do
    it 'should not save the page' do
      visit new_page_path
      within('form#new_page') do
        click_on 'Save'
      end
      expect(page).to have_content("Title can't be blank")
    end
  end
end
