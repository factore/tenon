require 'spec_helper'
include RequestHelpers

describe 'An admin viewing the contacts index', js: true do
  let!(:admin) { FactoryGirl.create(:admin) }

  context 'when there is a contact' do
    let!(:contact) { create(:contact) }
    before do
      login(admin)
    end

    it 'should see the contact in a list' do
      visit contacts_path
      expect(page).to have_content('Test Comment')
    end

    it 'should be able to delete the contact' do
      visit contacts_path
      click_on 'Delete'
      expect(page).not_to have_content('Test Comment')
    end

    it 'should be able to approve the contact' do
      visit contacts_path
      within('ul#contacts') do
        expect(page).not_to have_selector('a.unapprove')
        page.find('a.approve').click
        expect(page).to have_selector('a.unapprove')
        expect(contact.reload.approved?).to be_true
      end
    end

    it 'should be able to unapprove the contact' do
      contact.update_attributes(approved: true)
      visit contacts_path

      within('ul#contacts') do
        expect(page).not_to have_selector('a.approve')
        page.find('a.unapprove').click
        expect(page).to have_selector('a.approve')
        expect(contact.reload.approved?).to be_false
      end
    end
  end
end
