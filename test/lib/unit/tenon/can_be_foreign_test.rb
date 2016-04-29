require 'test_helper'

connection = ActiveRecord::Base.connection
connection.drop_table :dogs rescue nil
connection.create_table :dogs do |t|
  # Nada
end

class Dog < ActiveRecord::Base
end

module Tenon
  class CanBeForeignTest < ActiveSupport::TestCase
    test '#foreign_fields looks up the fields from Tenon::I18nFields' do
      Tenon::I18nLookup = stub(fields: { dog: :stubbed_dog_fields })
      assert_equal Dog.foreign_fields, :stubbed_dog_fields
    end
  end
end
