require 'spec_helper'

describe Tenon::Redirect do
  describe '.active' do
    it 'should find redirects that are active' do
      expect(Tenon::Redirect).to receive(:where).with(active: true)
      Tenon::Redirect.active
    end
  end

  describe '#toggle_active!' do
    let(:redirect) { Tenon::Redirect.new(active: active) }
    context 'when active is true' do
      let(:active) { true }
      it 'should set active to false and save the redirect' do
        expect(redirect).to receive(:active=).with(false)
        expect(redirect).to receive(:save)
        redirect.toggle_active!
      end
    end

    context 'when active is false' do
      let(:active) { false }
      it 'should set active to true and save the redirect' do
        expect(redirect).to receive(:active=).with(true)
        expect(redirect).to receive(:save)
        redirect.toggle_active!
      end
    end
  end
end
