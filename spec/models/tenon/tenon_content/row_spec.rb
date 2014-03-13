require 'spec_helper'

describe TenonContent::Row do
  let(:row) { TenonContent::Row.new }

  describe '#set_row_type' do
    it 'should set the row type' do
      row.stub(:build_pieces)
      expect(row).to receive(:row_type=).with('TestType')
      row.set_row_type('TestType')
    end

    it 'should build the pieces' do
      rtc = double
      row.stub(:row_type=)
      row.stub(:row_type_class) { rtc }
      expect(rtc).to receive(:add_pieces_to).with(row)
      row.set_row_type('TestType')
    end
  end

  describe '#row_type_class' do
    before do
      stub_const('TenonContent::RowTypes::TestType', test_type)
    end
    let(:test_type) { double }

    it 'should return a const' do
      row.row_type = 'TestType'
      expect(row.row_type_class).to eq(test_type)
    end
  end

end
