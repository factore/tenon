require 'test_helper'

class DummyClass
  include Tenon::Reorderable
  attr_accessor :id, :list_order

  def initialize(id)
    @id = id
  end

  def save
    true
  end
end

module Tenon
  class ReorderableTest < ActiveSupport::TestCase
    test '.reorder! sets the correct list_order on the correct item' do
      one, two, three = DummyClass.new(1), DummyClass.new(2), DummyClass.new(3)
      DummyClass.stubs(:find_by_id).with(1).returns(one)
      DummyClass.stubs(:find_by_id).with(2).returns(two)
      DummyClass.stubs(:find_by_id).with(3).returns(three)
      DummyClass.reorder!([2, 1, 3])
      assert_equal [one.list_order, two.list_order, three.list_order], [1, 0, 2]
    end
  end
end
