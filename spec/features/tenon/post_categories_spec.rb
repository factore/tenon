require 'spec_helper'
include RequestHelpers

describe 'An admin', js: true do
  let!(:admin) { create(:admin) }

  before do
    login(admin)
  end

  describe 'viewing the post categories index' do
    context 'when there is a post category' do
      let!(:post_category) { create(:post_category) }

      it 'should see the post category in a list' do
        visit post_categories_path
        expect(page).to have_content(post_category.title)
      end

      it 'should be able to delete the post category' do
        visit post_categories_path
        within 'ul#post_categories' do
          click_on 'Delete'
        end
        expect(page).not_to have_content(post_category.title)
      end
    end
  end

  describe 'creating a new post category' do
    context 'when doing everything right' do
      it 'should be able to save the post category' do
        visit post_categories_path
        click_on 'New Post Category'
        within('form#new_post_category') do
          fill_in 'post_category[title]', with: 'My Test PostCategory'
          click_button 'Save'
        end
        expect(page).to have_content('My Test PostCategory')
      end
    end

    context 'when doing something wrong' do
      it 'should see validation errors' do
        visit post_categories_path
        click_on 'New Post Category'
        within('form#new_post_category') do
          click_button 'Save'
        end
        expect(page).to have_content("Title can't be blank")
      end
    end
  end

  describe 'editing a post category' do
    let!(:post_category) { create(:post_category) }

    context 'when doing everything right' do
      it 'should save the post category' do
        visit post_categories_path
        within("li[data-record-id='#{post_category.id}']") do
          click_on 'Edit'
        end
        within('form.edit_post_category') do
          fill_in 'post_category[title]', with: 'My Test PostCategory'
          click_button 'Save'
        end
        within("li[data-record-id='#{post_category.id}']") do
          expect(page).to have_content('My Test PostCategory')
        end
      end
    end

    context 'when doing something wrong' do
      it 'should see validation errors' do
        visit post_categories_path

        within("li[data-record-id='#{post_category.id}']") do
          click_on 'Edit'
        end

        within('form.edit_post_category') do
          fill_in 'post_category[title]', with: ''
          click_button 'Save'
        end
        expect(page).to have_content("Title can't be blank")
      end
    end
  end

end
