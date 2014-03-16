require 'spec_helper'

connection = ActiveRecord::Base.connection
connection.drop_table :dogs rescue nil
connection.create_table :dogs do |t|
  # Nada
end

class Dog < ActiveRecord::Base
  tenon_content :content
end

describe Tenon::TenonContent do
  let(:dog) { Dog.new }
  it 'should respond_to :content_tenon_content_rows' do
    expect(dog).to respond_to(:content_tenon_content_rows)
  end

  it 'should respond_to :content_tenon_content_rows_attributes=' do
    expect(dog).to respond_to(:content_tenon_content_rows_attributes=)
  end
end
