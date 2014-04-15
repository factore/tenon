require 'spec_helper'

describe Tenon::Contact do
  describe '#toggle_read!' do
    let(:contact) { Tenon::Contact.new(read: read) }
    context 'when a read is true' do
      let(:read) { true }
      it 'should set read to false and save the contact' do
        expect(contact).to receive(:read=).with(false)
        expect(contact).to receive(:save)
        contact.toggle_read!
      end
    end

    context 'when read is false' do
      let(:read) { false }
      it 'should set read to true and save the contact' do
        expect(contact).to receive(:read=).with(true)
        expect(contact).to receive(:save)
        contact.toggle_read!
      end
    end
  end

  describe '#toggle_replied!' do
    let(:contact) { Tenon::Contact.new(replied: replied) }
    context 'when a replied is true' do
      let(:replied) { true }
      it 'should set replied to false and save the contact' do
        expect(contact).to receive(:replied=).with(false)
        expect(contact).to receive(:save)
        contact.toggle_replied!
      end
    end

    context 'when replied is false' do
      let(:replied) { false }
      it 'should set replied to true and save the contact' do
        expect(contact).to receive(:replied=).with(true)
        expect(contact).to receive(:save)
        contact.toggle_replied!
      end
    end
  end
end
