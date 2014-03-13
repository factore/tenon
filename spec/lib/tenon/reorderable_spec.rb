require 'spec_helper'

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

describe 'Tenon::Reorderable' do
  it 'should set the list order on the correct item' do
    one, two, three = DummyClass.new(1), DummyClass.new(2), DummyClass.new(3)
    DummyClass.stub(:find_by_id).with(1).and_return(one)
    DummyClass.stub(:find_by_id).with(2).and_return(two)
    DummyClass.stub(:find_by_id).with(3).and_return(three)
    DummyClass.reorder!([2, 1, 3])
    [one.list_order, two.list_order, three.list_order].should == [1, 0, 2]
  end
end
