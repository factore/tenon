require 'spec_helper'
include RequestHelpers

describe 'An admin', js: true do
  let!(:admin) { create(:admin) }

  before do
    login(admin)
  end

  describe 'viewing the settings page' do
    context 'when settings have previously been set' do
      before do
        Tenon::MySettings.site_title = 'Site Title'
        Tenon::MySettings.site_url = 'http://google.com'
        Tenon::MySettings.google_analytics = '<script></script>'
        Tenon::MySettings.comment_email = true
        Tenon::MySettings.contact_email = 'info@factore.ca'
        Tenon::MySettings.from_email = 'noreply@factore.ca'
      end

      it 'should see all the settings in the form' do
        visit settings_path
        expect(page.find('#settings_site_title').value).to eq(Tenon::MySettings.site_title)
        expect(page.find('#settings_site_url').value).to eq(Tenon::MySettings.site_url)
        expect(page.find('#settings_google_analytics').value).to eq(Tenon::MySettings.google_analytics)
        expect(page.find('#settings_contact_email').value).to eq(Tenon::MySettings.contact_email)
        expect(page.find('#settings_from_email').value).to eq(Tenon::MySettings.from_email)
        expect(page.find('#settings_comment_email')).to be_checked
      end
    end

    context 'when settings have not been set up' do
      it 'should be able to set and save the settings' do
        visit settings_path
        fill_in 'settings[site_title]', with: 'New Site Title'
        fill_in 'settings[site_url]', with: 'http://factore.ca'
        fill_in 'settings[google_analytics]', with: 'analytics'
        fill_in 'settings[contact_email]', with: 'contact@factore.ca'
        fill_in 'settings[from_email]', with: 'reply@factore.ca'
        click_button 'Save'

        visit settings_path
        expect(page.find('#settings_site_title').value).to eq('New Site Title')
        expect(page.find('#settings_site_url').value).to eq('http://factore.ca')
        expect(page.find('#settings_google_analytics').value).to eq('analytics')
        expect(page.find('#settings_contact_email').value).to eq('contact@factore.ca')
        expect(page.find('#settings_from_email').value).to eq('reply@factore.ca')
        expect(page.find('#settings_comment_email')).not_to be_checked
      end
    end
  end
end
