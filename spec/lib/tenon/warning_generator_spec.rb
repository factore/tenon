require 'spec_helper'

describe Tenon::WarningGenerator do
  let(:settings) { double.as_null_object }
  let(:wg) { Tenon::WarningGenerator.new }
  root_path = '/tenon/'
  before do
    stub_const('Tenon::MySettings', settings)
  end

  context 'when there is no site title' do
    before do
      settings.stub(:site_title) { nil }
    end

    it 'should include a warning about no site title' do
      warning = "Your site needs a title.<br /><br /><a class='btn btn-comp btn-block' href='#{root_path}settings'>OK</a>"
      expect(wg.warnings(root_path)).to include(warning)
    end
  end

  context 'when there is a site title' do
    before do
      settings.stub(:site_title) { 'test' }
    end

    it 'should not include a warning about no site title' do
      warning = "Your site needs a title.<br /><br /><a class='btn btn-comp btn-block' href='#{root_path}settings'>OK</a>"
      expect(wg.warnings(root_path)).not_to include(warning)
    end
  end

  context 'when there is no site domain' do
    before do
      settings.stub(:site_url) { nil }
    end

    it 'should include a warning about no site domain' do
      warning = "Your site needs an address.<br /><br /><a class='btn btn-comp btn-block' href='#{root_path}settings'>OK</a>"
      expect(wg.warnings(root_path)).to include(warning)
    end
  end

  context 'when there is a site domain' do
    before do
      settings.stub(:site_url) { 'test' }
    end

    it 'should not include a warning about no site title' do
      warning = "Your site needs an address.<br /><br /><a class='btn btn-comp btn-block' href='#{root_path}settings'>OK</a>"
      expect(wg.warnings(root_path)).not_to include(warning)
    end
  end

  context 'when there is no contact email' do
    before do
      settings.stub(:contact_email) { nil }
    end

    it 'should include a warning about no contact email' do
      warning = "You haven't entered an email address to receive contact messages.<br /><br /><a class='btn btn-comp btn-block' href='#{root_path}settings'>Correct This</a>"
      expect(wg.warnings(root_path)).to include(warning)
    end
  end

  context 'when there is a contact email' do
    before do
      settings.stub(:contact_email) { 'test' }
    end

    it 'should include a warning about no contact email' do
      warning = "You haven't entered an email address to receive contact messages.<br /><br /><a class='btn btn-comp btn-block' href='#{root_path}settings'>Correct This</a>"
      expect(wg.warnings(root_path)).not_to include(warning)
    end
  end

  context 'when there is no from email' do
    before do
      settings.stub(:from_email) { nil }
    end

    it 'should include a warning about no from email' do
      warning = "You haven't entered an email address from which to send contact messages and other site notices.<br /><br /><a class='btn btn-comp btn-block' href='#{root_path}settings'>Correct This</a>"
      expect(wg.warnings(root_path)).to include(warning)
    end
  end

  context 'when there is a from email' do
    before do
      settings.stub(:from_email) { 'test' }
    end

    it 'should not include a warning about no from email' do
      warning = "You haven't entered an email address from which to send contact messages and other site notices.<br /><br /><a class='btn btn-comp btn-block' href='#{root_path}settings'>Correct This</a>"
      expect(wg.warnings(root_path)).not_to include(warning)
    end
  end

  context 'when there is no Google Analytics' do
    before do
      settings.stub(:google_analytics) { nil }
    end

    it 'should include a warning about no Google Analytics' do
      warning = "You haven't entered the Google Analytics code.<br /><br /><a class='btn btn-comp btn-block' href='#{root_path}settings'>Correct This</a>"
      expect(wg.warnings(root_path)).to include(warning)
    end
  end

  context 'when there is a Google Analytics' do
    before do
      settings.stub(:google_analytics) { 'test' }
    end

    it 'should not include a warning about no Google Analytics' do
      warning = "You haven't entered the Google Analytics code.<br /><br /><a class='btn btn-comp btn-block' href='#{root_path}settings'>Correct This</a>"
      expect(wg.warnings(root_path)).not_to include(warning)
    end
  end

  context 'when there is no favicon' do
    before do
      wg.stub(:favicon) { nil }
    end

    it 'should include a warning about no favicon' do
      warning = 'You have not included a custom favicon.'
      expect(wg.warnings(root_path)).to include(warning)
    end
  end

  context 'when there is a favicon but its size is 0' do
    before do
      wg.stub(:favicon) { double(size: 0) }
    end

    it 'should include a warning about no favicon' do
      warning = 'You have not included a custom favicon.'
      expect(wg.warnings(root_path)).to include(warning)
    end
  end

  context 'when there is a good favicon' do
    before do
      wg.stub(:favicon) { double(size: 0.1) }
    end

    it 'should not include a warning about no favicon' do
      warning = 'You have not included a custom favicon.'
      expect(wg.warnings(root_path)).not_to include(warning)
    end
  end
end
