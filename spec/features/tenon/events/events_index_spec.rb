require 'spec_helper'
include RequestHelpers

describe 'Viewing the list of events', js: true do
  let!(:admin) { create(:admin) }

  before do
    login(admin)
  end

  context 'when there is a event' do
    let!(:event) { create(:event) }

    it 'should see the event in a list' do
      visit events_path
      expect(page).to have_content(event.title)
    end

    it 'should delete the event' do
      visit events_path
      within 'ul#events' do
        click_on 'Delete'
      end
      expect(page).not_to have_content(event.title)
    end
  end

  context 'when there are two events' do
    let!(:old_event) { create(:event) }
    let!(:new_event) {
      create(
        :event,
        starts_at: Time.now + 1.day,
        ends_at: Time.now + 1.day + 1.hour
      )
    }

    it 'should show the new event first' do
      visit events_path
      within('ul#events li:first-child') do
        expect(page).to have_content new_event.title
      end
      within('ul#events li:last-child') do
        expect(page).to have_content old_event.title
      end
    end
  end
end
