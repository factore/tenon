require 'spec_helper'

describe Contact do
  describe '.new' do
    it "should accept a hash of attributes ActiveRecord style" do
      c = Contact.new(name: 'Sean', email: 'sean@factore.ca')
      expect(c.name).to eq 'Sean'
      expect(c.email).to eq 'sean@factore.ca'
    end
  end

  describe '#persisted?' do
    it "should always be false" do
      expect(Contact.new.persisted?).to be_false
    end
  end
end
