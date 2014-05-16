require 'spec_helper'
include RequestHelpers

describe 'An admin', js: true do
  let!(:admin) { create(:admin) }

  before do
    login(admin)
  end

  describe 'viewing the posts index' do
    context 'when there is a post' do
      let!(:post) { create(:post) }

      it 'should see the post in a list' do
        visit posts_path
        expect(page).to have_content(post.title)
      end

      it 'should be able to delete the post' do
        visit posts_path
        within 'ul#posts' do
          click_on 'Delete'
        end
        expect(page).not_to have_content(post.title)
      end
    end

    context 'when there are two posts' do
      let!(:old_post) { create(:post) }
      let!(:new_post) { create(:post, created_at: Time.now + 1.day, title: 'New Post') }

      it 'should see the new post first' do
        visit posts_path
        within('ul#posts li:first-child') do
          expect(page).to have_content new_post.title
        end
        within('ul#posts li:last-child') do
          expect(page).to have_content old_post.title
        end
      end
    end
  end

  describe 'creating a new post' do
    context 'when doing everything right' do
      it 'should be able to save the post' do
        visit new_post_path
        within('form#new_post') do
          fill_in 'post[title]', with: 'My Test Post'
          click_button 'Save'
        end
        expect(page).to have_content('My Test Post')
        expect(page).to have_content('Post saved successfully.')
      end
    end

    context 'when doing something wrong' do
      it 'should see validation errors' do
        visit new_post_path
        within('form#new_post') do
          click_button 'Save'
        end
        expect(page).to have_content("Title can't be blank")
      end
    end
  end

  describe 'editing a post' do
    let!(:post) { create(:post) }
    context 'when doing everything right' do
      it 'should save the post' do
        visit edit_post_path(post)
        within('form.edit_post') do
          fill_in 'post[title]', with: 'My Test Post'
          click_button 'Save'
        end
        expect(page).to have_content('My Test Post')
        expect(page).to have_content('Post saved successfully.')
      end
    end

    context 'when doing something wrong' do
      it 'should see validation errors' do
        visit edit_post_path(post)
        within('form.edit_post') do
          fill_in 'post[title]', with: ''
          click_button 'Save'
        end
        expect(page).to have_content("Title can't be blank")
      end
    end
  end

end
