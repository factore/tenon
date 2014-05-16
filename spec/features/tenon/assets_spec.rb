require 'spec_helper'
include RequestHelpers

describe 'An admin', js: true do
  let!(:admin) { create(:admin) }

  let!(:file) do
    File.join(File.dirname(__FILE__), '..', '..', 'fixtures', 'files/test.png')
  end

  before do
    login(admin)
  end

  describe 'viewing the assets index' do
    context 'when there is an asset' do
      let!(:asset) { create(:asset) }

      it 'should see the asset in a list' do
        visit assets_path
        expect(page).to have_content(asset.attachment_file_name)
      end

      it 'should be able to delete the asset' do
        visit assets_path
        within 'ul#assets' do
          click_on 'Delete'
        end
        expect(page).not_to have_content(asset.attachment_file_name)
      end
    end
  end

  describe 'creating a new asset' do
    it 'TODO: Figure out how to test jQuery file uploads'
    # it 'should be able to save the asset' do
    #   visit assets_path
    #   click_on 'Upload New'
    #   within('form#new_asset') do
    #     page.attach_file 'asset[attachment]', file
    #   end

    #   within('ul#assets') do
    #     expect(page).to have_content('test.png')
    #   end
    # end
  end

  describe 'editing an asset' do
    let!(:asset) { create(:asset) }

    context 'when supplying a title' do
      it 'should save the asset' do
        visit assets_path
        within("li[data-record-id='#{asset.id}']") do
          click_on 'Edit'
        end
        within('form.edit_asset') do
          fill_in 'asset[title]', with: 'My Test Asset'
          click_button 'Save'
        end
        within("li[data-record-id='#{asset.id}']") do
          expect(page).to have_content('My Test Asset')
        end
      end
    end

    context 'when not supplying a title' do
      it 'should continue to just use the asset file name' do
        visit assets_path

        within("li[data-record-id='#{asset.id}']") do
          click_on 'Edit'
        end

        within('form.edit_asset') do
          fill_in 'asset[title]', with: ''
          click_button 'Save'
        end

        within("li[data-record-id='#{asset.id}']") do
          expect(page).to have_content('test.png')
        end
      end
    end
  end

end
