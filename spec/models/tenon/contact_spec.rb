require 'spec_helper'

describe Tenon::Contact do
  describe '.create_contact' do
    let(:object) { double(id: 1) }

    context 'when a session is passed' do
      it "should create a contact with the session's attributes" do
        session = { one: 'one', two: 'two' }
        expect(Tenon::Contact).to receive(:new).with(session)
        Tenon::Contact.create_contact(object, session)
      end
    end

    context 'when session is nil' do
      it "should create a contact with the object's details" do
        info = { contactable_type: object.class.to_s, contactable_id: 1 }
        expect(Tenon::Contact).to receive(:new).with(info)
        Tenon::Contact.create_contact(object, nil)
      end
    end
  end

  # TODO: The fact that we're testing behaviour that's encapsulated
  # in a private method called by a callback tells me that we need
  # rethink how this is handled.
  describe '#save' do
    before do
      @contact = Tenon::Contact.new
      @contact.stub(:valid?).and_return(true)
      @contact.stub(:approved?).and_return(true)
    end

    it 'creates a contact subscriber' do
      @contact.subscribe = 1
      @contact.stub_chain(:contactable, :subscribers).and_return([])

      Tenon::ContactSubscriber.should_receive(:create)
      @contact.save
    end

    it 'notifies subscribers' do
      @contact.subscribe = 0
      subscriber = double('subscriber', email: 'something@something.com')
      @contact.stub_chain(:contactable, :subscribers).and_return([subscriber])
      Tenon::ContactMailer.stub_chain(:contact_notification, :deliver)

      Tenon::ContactMailer.should_receive(:contact_notification)
      @contact.save
    end
  end

  describe '#approve!' do
    let(:contact) { Tenon::Contact.new }
    it 'should set approved to true and save the contact' do
      expect(contact).to receive(:approved=).with(true)
      expect(contact).to receive(:save)
      contact.approve!
    end
  end

  describe '#unapprove!' do
    let(:contact) { Tenon::Contact.new }
    it 'should set approved to true and save the contact' do
      expect(contact).to receive(:approved=).with(false)
      expect(contact).to receive(:save)
      contact.unapprove!
    end
  end

  describe '#approve!' do
    let(:contact) { Tenon::Contact.new }
    it 'should set approved to true' do
      expect(contact).to receive(:approved=).with(true)
      contact.approve
    end
  end
end
