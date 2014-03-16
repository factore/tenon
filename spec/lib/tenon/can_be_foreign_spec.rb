require 'spec_helper'

connection = ActiveRecord::Base.connection
connection.drop_table :dogs rescue nil
connection.create_table :dogs do |t|
  # Nada
end

class Dog < ActiveRecord::Base
end

describe Tenon::CanBeForeign do
  before do
    stub_const('Tenon::I18nFields', dog: 'dog_fields')
  end

  it 'should lookup the fields from Tenon::I18nFields' do
    expect(Dog.foreign_fields).to eq 'dog_fields'
  end
end
