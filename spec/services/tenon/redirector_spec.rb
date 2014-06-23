require 'spec_helper'

describe Tenon::Redirector do
  describe '.redirect' do
    before do
      Tenon::Redirect.create(in: '\/a-page', out: '/new-page', list_order: 0)
      Tenon::Redirect.create(in: '\/on-the-floor\/(\d+-.*)', out: '/posts/{0}', list_order: 1)
      Tenon::Redirect.create(in: '\/on-the-floor.*', out: '/posts', list_order: 2)
    end

    context 'finds a redirect match' do
      it 'should return a destination path' do
        redirector = Tenon::Redirector.new('/a-page')
        expect(redirector.redirect).to eq('/new-page')
      end

      it 'should return the first match ordered by list_order' do
        redirector = Tenon::Redirector.new('/on-the-floor/1-something')
        expect(redirector.redirect).to eq('/posts/1-something')
      end
    end

    context 'does not find a redirect match' do
      it 'should raise 404' do
        redirector = Tenon::Redirector.new('/not-on-the-floor/1-something')
        expect{ redirector.redirect }.to raise_error{ ActiveRecord::RecordNotFound }
      end
    end
  end
end
