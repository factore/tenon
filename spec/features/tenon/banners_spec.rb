require 'spec_helper'
include RequestHelpers

describe 'An admin', js: true do
  let!(:file) do
    File.join(Tenon::Engine.root, 'spec', 'fixtures', 'files/test.png')
  end

  let!(:admin) { create(:admin) }

  before do
    login(admin)
  end

  describe 'viewing the banners index' do
    context 'when there is a banner' do
      let!(:banner) { create(:banner) }

      it 'should see the banner in a list' do
        visit banners_path
        expect(page).to have_content(banner.title)
      end

      it 'should be able to delete the banner' do
        visit banners_path
        within 'ul#banners' do
          click_on 'Delete'
        end
        expect(page).not_to have_content(banner.title)
      end
    end
  end

  describe 'creating a new banner' do
    context 'when doing everything right' do
      it 'TODO: Figure out how to test jQuery File Uploads'
      # it 'should be able to save the banner' do
      #   visit new_banner_path
      #   within('form#new_banner') do
      #     fill_in 'banner[title]', with: 'My Test Banner'

      #     within('.asset-field') do
      #       page.find('a.browse').click
      #     end
      #   end

      #   within('.modal-body') do
      #     attach_file 'asset[attachment]', file
      #   end

      #   click_on 'Save'

      #   expect(page).to have_content('My Test Banner')
      #   expect(page).to have_content('Banner saved successfully.')
      # end
    end

    context 'when doing something wrong' do
      it 'should see validation errors' do
        visit new_banner_path
        within('form#new_banner') do
          click_on 'Save'
        end
        expect(page).to have_content("Title can't be blank")
      end
    end
  end

  describe 'editing a banner' do
    let(:banner) { create(:banner) }

    context 'when doing everything right' do
      it 'should be able to save the banner' do
        visit edit_banner_path(banner)

        within('form.edit_banner') do
          fill_in 'banner[title]', with: 'My Test Banner'
          click_on 'Save'
        end
        expect(page).to have_content('My Test Banner')
        expect(page).to have_content('Banner saved successfully.')
      end
    end

    context 'when doing something wrong' do
      it 'should see validation errors' do
        visit edit_banner_path(banner)
        within('form.edit_banner') do
          fill_in 'banner[title]', with: ''
          click_on 'Save'
        end
        expect(page).to have_content("Title can't be blank")
      end
    end
  end
end
