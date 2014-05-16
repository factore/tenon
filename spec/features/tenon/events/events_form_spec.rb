require 'spec_helper'
include RequestHelpers

describe 'Using the event form', js: true do
  let!(:admin) { create(:admin) }

  before do
    login(admin)
  end

  context 'when doing everything right' do
    it 'should save the event' do
      visit new_event_path
      fill_in 'event[title]', with: 'My Test Event'

      # Manually testing the datepickers is outside the scope of this spec
      page.execute_script("$('#event_starts_at').val('#{Time.now}')")
      page.execute_script("$('#event_ends_at').val('#{Time.now + 1.hour}')")

      # Save it
      click_button 'Save'
      expect(page).to have_content('My Test Event')
      expect(page).to have_content('Event saved successfully.')
    end
  end

  context 'when doing something wrong' do
    it 'should not save the page' do
      visit new_event_path
      within('form#new_event') do
        click_button 'Save'
      end
      expect(page).to have_content("Title can't be blank")
      expect(page).to have_content("Starts at can't be blank")
      expect(page).to have_content("Ends at can't be blank")
    end
  end
end
