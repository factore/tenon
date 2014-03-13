require 'spec_helper'

connection = ActiveRecord::Base.connection
connection.drop_table :dogs rescue nil
connection.create_table :dogs do |t|
  # Nada
end

class Dog < ActiveRecord::Base
  can_have_comments
end

describe Tenon::CanHaveComments do
  let(:dog) { Dog.new }
  it "should respond_to :comments" do
    expect(dog).to respond_to (:comments)
  end

  it "should respond_to :subscribers" do
    expect(dog).to respond_to(:subscribers)
  end
end
