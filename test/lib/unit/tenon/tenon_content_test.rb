require 'test_helper'

connection = ActiveRecord::Base.connection
connection.drop_table :dogs rescue nil
connection.create_table :dogs do |t|
  # Nada
end

class Dog < ActiveRecord::Base
  tenon_content :content
end

module Tenon
  class TenonContentTest < ActiveSupport::TestCase
    test 'sets :content_tenon_content_rows' do
      dog = Dog.new
      assert dog.respond_to?(:content_tenon_content_rows)
    end

    test 'sets :content_tenon_content_rows_attributes=' do
      dog = Dog.new
      assert dog.respond_to?(:content_tenon_content_rows_attributes=)
    end
  end
end
