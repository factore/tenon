require 'spec_helper'
include RequestHelpers

describe 'Viewing the list of posts', js: true do
  let!(:admin) { create(:admin) }

  before do
    login(admin)
  end

  context 'when there is a post' do
    let!(:post) { create(:post) }


    it "should see the post in a list" do
      visit posts_path
      expect(page).to have_content(post.title)
    end

    it "should delete the post" do
      visit posts_path
      within 'ul#posts' do
        click_on 'Delete'
      end
      expect(page).not_to have_content(post.title)
    end
  end

  context "when there are two posts" do
    let!(:old_post) { create(:post) }
    let!(:new_post) { create(:post, created_at: Time.now + 1.day, title: 'New Post') }

    it "should show the new post first" do
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