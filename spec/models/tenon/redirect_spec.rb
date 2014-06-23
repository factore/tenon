require 'spec_helper'

describe Tenon::Redirect do
  describe '.active' do
    it 'should find redirects that are active' do
      expect(Tenon::Redirect).to receive(:where).with(active: true)
      Tenon::Redirect.active
    end
  end
end
