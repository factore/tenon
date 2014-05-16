require 'spec_helper'
include RequestHelpers

describe 'An admin', js: true do
  let!(:admin) { create(:admin) }

  before do
    login(admin)
  end

  describe 'viewing the list of pages' do

    context 'when there is a page' do
      let!(:page_obj) { create(:page) }

      it 'should see the page in a list' do
        visit pages_path
        expect(page).to have_content(page_obj.title)
      end

      it 'should be able to delete the page' do
        visit pages_path
        click_on 'Delete'
        expect(page).not_to have_content(page_obj.title)
      end
    end

    context 'when there is a page and a subpage' do
      let!(:page_obj) { create(:page) }
      let!(:subpage) { create(:page, parent: page_obj) }

      it 'should see the subpage nested under the page' do
        visit pages_path
        within("li[data-record-id='#{page_obj.id}'] > ul") do
          expect(page).to have_content(subpage.title)
        end
      end

      it 'should be able to delete the subpage' do
        visit pages_path
        within("li[data-record-id='#{page_obj.id}'] > ul") do
          click_on 'Delete'
          expect(page).not_to have_content(subpage.title)
        end
      end
    end
  end

  describe 'creating a new page' do
    context 'when doing everything right' do
      it 'should be able to save the page' do
        visit new_page_path
        within('form#new_page') do
          fill_in 'page[title]', with: 'My Test Page'
          click_button 'Save'
        end
        expect(page).to have_content('My Test Page')
        expect(page).to have_content('Page saved successfully.')
      end
    end

    context 'when doing something wrong' do
      it 'should see validation errors' do
        visit new_page_path
        within('form#new_page') do
          click_button 'Save'
        end
        expect(page).to have_content("Title can't be blank")
      end
    end
  end

  describe 'editing a page' do
    let!(:page_obj) { create(:page) }

    context 'when doing everything right' do
      it 'should be able to save the page' do
        visit edit_page_path(page_obj)
        within('form.edit_page') do
          fill_in 'page[title]', with: 'My Test Page'
          click_button 'Save'
        end
        expect(page).to have_content('My Test Page')
        expect(page).to have_content('Page saved successfully.')
      end
    end

    context 'when doing something wrong' do
      it 'should see validation errors' do
        visit edit_page_path(page_obj)
        within('form.edit_page') do
          fill_in 'page[title]', with: ''
          click_button 'Save'
        end
        expect(page).to have_content("Title can't be blank")
      end
    end
  end
end
