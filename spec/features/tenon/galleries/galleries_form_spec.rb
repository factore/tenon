require 'spec_helper'
include RequestHelpers

describe 'Using the gallery form', js: true do
  let!(:admin) { create(:admin) }

  before do
    login(admin)
  end

  context 'when doing everything right' do
    it 'should save the gallery' do
      visit new_gallery_path
      within('form#new_gallery') do
        fill_in 'gallery[title]', with: 'My Test Gallery'
        click_on 'Save'
      end
      expect(page).to have_content('My Test Gallery')
      expect(page).to have_content('Gallery saved successfully.')
    end
  end

  context 'when doing something wrong' do
    it 'should not save the page' do
      visit new_gallery_path
      within('form#new_gallery') do
        click_on 'Save'
      end
      expect(page).to have_content("Title can't be blank")
    end
  end

  context 'when trying to add photos' do
    # TODO: Figure out how to simulate uploads.
    # For now we'll just check if the buttons to add and remove work

    it 'should let the user add/remove a photo' do
      visit new_gallery_path
      click_on 'Add another photo'
      expect(page).to have_selector('.nested-field-list .nested-fields')

      click_on 'remove'
      expect(page).not_to have_selector('.nested-field-list .nested-fields')
    end
  end
end
