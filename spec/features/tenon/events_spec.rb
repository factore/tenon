require 'spec_helper'
include RequestHelpers

describe 'An admin', js: true do
  let!(:admin) { create(:admin) }

  before do
    login(admin)
  end

  describe 'viewing the events index' do
    context 'when there is a event' do
      let!(:event) { create(:event) }

      it 'should see the event in a list' do
        visit events_path
        expect(page).to have_content(event.title)
      end

      it 'should be able to delete the event' do
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

      it 'should see the new event first' do
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

  describe 'creating a new event' do
    context 'when doing everything right' do
      it 'should be able to save an event' do
        visit new_event_path
        fill_in 'event[title]', with: 'My Test Event'

        # Manually testing the datepickers is outside the scope of this spec
        page.execute_script("$('#event_starts_at').val('#{Time.now}')")
        page.execute_script("$('#event_ends_at').val('#{(Time.now + 1.hour)}')")

        # Save it
        click_on 'Save'
        expect(page).to have_content('My Test Event')
        expect(page).to have_content('Event saved successfully.')
      end
    end

    context 'when doing something wrong' do
      it 'should see validation errors' do
        visit new_event_path
        within('form#new_event') do
          click_on 'Save'
        end
        expect(page).to have_content("Title can't be blank")
        expect(page).to have_content("Starts at can't be blank")
        expect(page).to have_content("Ends at can't be blank")
      end
    end
  end

  describe 'editing an event' do
    let!(:event) { create(:event) }
    context 'when doing everything right' do
      it 'should be able to save the event' do
        visit edit_event_path(event)
        fill_in 'event[title]', with: 'My Test Event'

        # Save it
        click_on 'Save'
        expect(page).to have_content('My Test Event')
        expect(page).to have_content('Event saved successfully.')
      end
    end

    context 'when doing something wrong' do
      it 'should see validation errors' do
        visit edit_event_path(event)
        fill_in 'event[title]', with: ''
        within('form.edit_event') do
          click_on 'Save'
        end
        expect(page).to have_content("Title can't be blank")
      end
    end
  end
end
