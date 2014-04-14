require 'spec_helper'

describe Tenon::ContactDecorator do
  let (:cd) { Tenon::ContactDecorator.new(contact) }

  describe '#email' do
    let(:contact) { double(author_email: 'test@test.com') }
    it 'should get the author email from the object' do
      expect(cd.email).to eq('test@test.com')
    end
  end

  describe '#author_url' do
    ['http://', 'https://'].each do |protocol|
      context "when the author has started their URL with #{protocol}" do
        let(:contact) { double(author_url: "#{protocol}test.com") }

        it 'should use the author_url from the object' do
          expect(cd.author_url).to eq(contact.author_url)
        end
      end
    end

    context 'when the author has not included a protocol' do
      let(:contact) { double(author_url: 'test.com') }

      it "should prepend 'http://' to the url" do
        expect(cd.author_url).to eq("http://#{contact.author_url}")
      end
    end
  end

  describe '#error_message' do
    let(:errors) { double(full_messages: ['It sucks', "It's boring"]) }
    let(:contact) { double(errors: errors) }

    it 'should output the errors' do
      errors.full_messages.each do |error|
        expect(cd.error_message).to match(error)
      end
    end
  end
end
