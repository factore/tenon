require 'spec_helper'
include RequestHelpers

describe 'An admin', js: true do
  let!(:admin) { create(:admin) }

  before do
    login(admin)
  end

  describe 'viewing the galleries index' do
    context 'when there is a gallery' do
      let!(:gallery) { create(:gallery) }

      it 'should see the gallery in a list' do
        visit galleries_path
        expect(page).to have_content(gallery.title)
      end

      it 'should delete the gallery' do
        visit galleries_path
        within 'ul#galleries' do
          click_on 'Delete'
        end
        expect(page).not_to have_content(gallery.title)
      end
    end
  end

  describe 'creating a new gallery' do
    context 'when doing everything right' do
      it 'should be able to save the gallery' do
        visit new_gallery_path
        within('form#new_gallery') do
          fill_in 'gallery[title]', with: 'My Test Gallery'
          click_button 'Save'
        end
        expect(page).to have_content('My Test Gallery')
        expect(page).to have_content('Gallery saved successfully.')
      end
    end

    context 'when doing something wrong' do
      it 'should see validation errors' do
        visit new_gallery_path
        within('form#new_gallery') do
          click_button 'Save'
        end
        expect(page).to have_content("Title can't be blank")
      end
    end

    context 'when trying to add photos' do
      # TODO: Figure out how to simulate uploads.
      # For now we'll just check if the buttons to add and remove work

      it 'should be able to add and remove photos' do
        visit new_gallery_path
        click_on 'Add another photo'
        expect(page).to have_selector('.nested-field-list .nested-fields')

        click_on 'remove'
        expect(page).not_to have_selector('.nested-field-list .nested-fields')
      end
    end
  end

  describe 'editing a gallery' do
    let(:gallery) { create(:gallery) }

    context 'when doing everything right' do
      it 'should be able to save the gallery' do
        visit edit_gallery_path(gallery)

        within('form.edit_gallery') do
          fill_in 'gallery[title]', with: 'My Test Gallery'
          click_button 'Save'
        end
        expect(page).to have_content('My Test Gallery')
        expect(page).to have_content('Gallery saved successfully.')
      end
    end

    context 'when doing something wrong' do
      it 'should see validation errors' do
        visit edit_gallery_path(gallery)
        within('form.edit_gallery') do
          fill_in 'gallery[title]', with: ''
          click_button 'Save'
        end
        expect(page).to have_content("Title can't be blank")
      end
    end

    context 'when trying to add photos' do
      # TODO: Figure out how to simulate uploads.
      # For now we'll just check if the buttons to add and remove work

      it 'should be able to add and remove photos' do
        visit edit_gallery_path(gallery)
        click_on 'Add another photo'
        expect(page).to have_selector('.nested-field-list .nested-fields')

        click_on 'remove'
        expect(page).not_to have_selector('.nested-field-list .nested-fields')
      end
    end
  end
end
