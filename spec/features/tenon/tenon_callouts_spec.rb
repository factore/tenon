require 'spec_helper'
include RequestHelpers

describe 'An admin', js: true do
  let!(:admin) { create(:admin) }

  before do
    login(admin)
  end

  describe 'viewing the dashboard' do
    context 'when there is a tenon callout' do
      let!(:tenon_callout) { create(:tenon_callout, published: true) }

      it 'should see the tenon callout' do
        visit root_path
        expect(page).to have_content(tenon_callout.title)
        expect(page).to have_content(tenon_callout.content)
        expect(page).to have_selector('i.fa-file-o')
        expect(page).to have_content(tenon_callout.button_text.upcase)
        expect(page).to have_selector("a[href='#{tenon_callout.uri}']")
      end
    end
  end

  describe 'viewing the tenon_callouts index' do
    context 'when there is a tenon_callout' do
      let!(:tenon_callout) { create(:tenon_callout) }

      it 'should see the tenon_callout in a list' do
        visit tenon_callouts_path
        expect(page).to have_content(tenon_callout.title)
      end

      it 'should see the tenon_callout icon in the list' do
        visit tenon_callouts_path
        expect(page).to have_selector('i.fa-file-o')
      end

      it 'should be able to delete the tenon_callout' do
        visit tenon_callouts_path
        within 'ul#tenon_callouts' do
          click_on 'Delete'
        end
        expect(page).not_to have_content(tenon_callout.title)
      end
    end
  end

  describe 'creating a new tenon_callout' do
    context 'when doing everything right' do
      it 'should be able to save the tenon_callout' do
        visit new_tenon_callout_path
        within('form#new_tenon_callout') do
          fill_in 'tenon_callout[title]', with: 'My Test TenonCallout'
          fill_in 'tenon_callout[uri]', with: 'http://www.google.com'
          fill_in 'tenon_callout[icon]', with: 'file-o'
          fill_in 'tenon_callout[button_text]', with: 'Go!'
          click_on 'Save'
        end
        expect(page).to have_content('My Test TenonCallout')
        expect(page).to have_content('Tenon Callout saved successfully.')
      end
    end

    context 'when doing something wrong' do
      it 'should see validation errors' do
        visit new_tenon_callout_path
        within('form#new_tenon_callout') do
          click_on 'Save'
        end
        expect(page).to have_content("Title can't be blank")
      end
    end
  end

  describe 'editing a tenon_callout' do
    let!(:tenon_callout) { create(:tenon_callout) }
    context 'when doing everything right' do
      it 'should save the tenon_callout' do
        visit edit_tenon_callout_path(tenon_callout)
        within('form.edit_tenon_callout') do
          fill_in 'tenon_callout[title]', with: 'My Test TenonCallout'
          click_on 'Save'
        end
        expect(page).to have_content('My Test TenonCallout')
        expect(page).to have_content('Tenon Callout saved successfully.')
      end
    end

    context 'when doing something wrong' do
      it 'should see validation errors' do
        visit edit_tenon_callout_path(tenon_callout)
        within('form.edit_tenon_callout') do
          fill_in 'tenon_callout[title]', with: ''
          click_on 'Save'
        end
        expect(page).to have_content("Title can't be blank")
      end
    end
  end

end
