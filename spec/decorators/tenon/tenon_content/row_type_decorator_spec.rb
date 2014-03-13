require 'spec_helper'

describe Tenon::TenonContent::RowDecorator do
  let(:decorator) { Tenon::TenonContent::RowDecorator.new(row_type) }
  let(:row_type) { double(:row_type_class => row_type_class) }
  let(:row_type_class) do
    double(
      :partial => 'partial',
      :form_partial => 'form_partial'
    )
  end

  it 'should get the partial from the row type class' do
    expect(decorator.partial).to eq('partial')
  end

  it 'should get the form_partial from the row type class' do
    expect(decorator.form_partial).to eq('form_partial')
  end
end
