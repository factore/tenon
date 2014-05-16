require 'spec_helper'

describe Tenon::ContactDecorator do
  let (:cd) { Tenon::ContactDecorator.new(contact) }

  describe '#sent_date' do
    let(:contact) { double(created_at: Time.new(2014, 03, 26)) }
    it 'should return created_at as %B %e, %Y at %l:%M %p' do
      expect(cd.sent_date).to eq(Time.new(2014, 03, 26).strftime('%B %e, %Y at %l:%M %p'))
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
