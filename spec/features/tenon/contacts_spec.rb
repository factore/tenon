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
      expect(page).to have_content('This is the message!')
    end

    it 'should be able to delete the contact' do
      visit contacts_path
      click_on 'Delete'
      expect(page).not_to have_content('This is the message!')
    end

    %w(read replied).each do |action|
      context "if #{action} is false" do
        it "should be able to toggle #{action} to true" do
          visit contacts_path
          within('ul#contacts') do
            expect(page).to have_selector("a.toggle.#{action}.false")
            page.find("a.toggle.#{action}").click
            expect(contact.reload.send("toggle_#{action}!")).to be_true
            expect(page).to have_selector("a.toggle.#{action}.true")
          end
        end

        context "if #{action} is true" do
          it "should be able to toggle #{action} to false" do
            contact.update_attributes(action.to_sym => true)
            visit contacts_path
            within('ul#contacts') do
              expect(page).to have_selector("a.toggle.#{action}.true")
              page.find("a.toggle.#{action}").click
              expect(contact.reload.send("toggle_#{action}!")).to be_true
              expect(page).to have_selector("a.toggle.#{action}.false")
            end
          end
        end
      end
    end
  end
end
