require 'spec_helper'

describe Tenon::I18nLookup do
  describe ".new" do
    it "should assign @klass" do
      i = Tenon::I18nLookup.new(String)
      expect(i.instance_variable_get('@klass')).to eq(String)
    end
  end

  describe '#fields' do

    context "when there's no match for the class" do
      before do
        Tenon::I18nLookup.stub(:fields) { {
          tables: {}
        }}
      end

      it "should return an empty array" do
        expect(Tenon::I18nLookup.new(String).fields).to eq([])
      end
    end

    context "when there's a match for the class" do
      before do
        Tenon::I18nLookup.stub(:fields) { {
          tables: {:strings => ['a', 'b', 'c']}
        }}
      end

      it "should return the field names" do
        expect(Tenon::I18nLookup.new(String).fields).to eq(['a', 'b', 'c'])
      end
    end
  end

  describe ".fields" do
    before do
      # Reset the class variable before each spec
      Tenon::I18nLookup.class_variable_set :@@fields, nil
    end

    it "should load the YAML" do
      expect(YAML).to receive(:load) { {} }
      Tenon::I18nLookup.fields
    end

    it "should symbolize the keys" do
      yaml = double
      YAML.stub(:load) { yaml }
      expect(yaml).to receive(:recursive_symbolize_keys!)
      Tenon::I18nLookup.fields
    end
  end
end
