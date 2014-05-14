require 'spec_helper'
include RequestHelpers

describe 'An admin viewing the comments index', js: true do
  let!(:admin) { FactoryGirl.create(:admin) }

  context 'when there is a comment' do
    let!(:comment) { create(:comment) }
    before do
      login(admin)
    end

    it 'should see the comment in a list' do
      visit comments_path
      expect(page).to have_content('Test Comment'.upcase)
    end

    it 'should be able to delete the comment' do
      visit comments_path
      click_on 'Delete'
      expect(page).not_to have_content('Test Comment')
    end

    %w(approved).each do |action|
      context "if #{action} is false" do
        it "should be able to toggle #{action} to true" do
          visit comments_path
          within('ul#comments') do
            expect(page).to have_selector("a.toggle.#{action}.false")
            page.find("a.toggle.#{action}").click
            expect(comment.reload.send("toggle_#{action}!")).to be_true
            expect(page).to have_selector("a.toggle.#{action}.true")
          end
        end

        context "if #{action} is true" do
          it "should be able to toggle #{action} to false" do
            comment.update_attributes(action.to_sym => true)
            visit comments_path
            within('ul#comments') do
              expect(page).to have_selector("a.toggle.#{action}.true")
              page.find("a.toggle.#{action}").click
              expect(comment.reload.send("toggle_#{action}!")).to be_true
              expect(page).to have_selector("a.toggle.#{action}.false")
            end
          end
        end
      end
    end
  end
end
