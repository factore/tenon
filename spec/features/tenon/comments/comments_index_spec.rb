require 'spec_helper'
include RequestHelpers

describe 'Viewing a list of comments', js: true do
  let!(:admin) { FactoryGirl.create(:admin) }

  context 'when there is a comment' do
    let!(:comment) { create(:comment) }
    before do
      login(admin)
    end

    it 'should see the comment in a list' do
      visit comments_path
      expect(page).to have_content('Test Comment')
    end

    it 'should delete a comment' do
      visit comments_path
      click_on 'Delete'
      expect(page).not_to have_content('Test Comment')
    end

    it 'should approve a comment' do
      visit comments_path
      within('ul#comments') do
        expect(page).not_to have_selector('a.unapprove')
        page.find('a.approve').click
        expect(page).to have_selector('a.unapprove')
        expect(comment.reload.approved?).to be_true
      end
    end

    it 'should unapprove a comment' do
      comment.update_attributes(approved: true)
      visit comments_path

      within('ul#comments') do
        expect(page).not_to have_selector('a.approve')
        page.find('a.unapprove').click
        expect(page).to have_selector('a.approve')
        expect(comment.reload.approved?).to be_false
      end
    end
  end
end
