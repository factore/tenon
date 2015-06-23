require 'spec_helper'

describe Tenon::I18nLookup do
  describe '.new' do
    context "when the given class is a Decorator" do
      it 'assigns the decorated class.to_s to @klass' do
        i = Tenon::I18nLookup.new(Tenon::Post.new.decorate.class)
        expect(i.instance_variable_get('@klass')).to eq(Tenon::Post.new.class.to_s)
      end
    end

    context "when the given class is not a Decorator" do
      it 'assigns class.to_s to @klass' do
        i = Tenon::I18nLookup.new(String)
        expect(i.instance_variable_get('@klass')).to eq(String.to_s)
      end
    end
  end

  describe '#fields' do
    context "when there's no match for the class" do
      before do
        Tenon::I18nLookup.stub(:fields) do {
          tables: {}
        }
        end
      end

      it 'should return an empty array' do
        expect(Tenon::I18nLookup.new(String).fields).to eq([])
      end
    end

    context "when there's a match for the class" do
      before do
        Tenon::I18nLookup.stub(:fields) do {
          tables: { strings: %w(a b c) }
        }
        end
      end

      it 'should return the field names' do
        expect(Tenon::I18nLookup.new(String).fields).to eq(%w(a b c))
      end
    end
  end

  describe '.fields' do
    before do
      # Reset the class variable before each spec
      Tenon::I18nLookup.class_variable_set :@@fields, nil
    end

    context 'when the file exists' do
      before do
        File.stub(:exist?) { true }
      end

      it 'should load the YAML' do
        expect(YAML).to receive(:load) { {} }
        Tenon::I18nLookup.fields
      end

      it 'should symbolize the keys' do
        yaml = double
        YAML.stub(:load) { yaml }
        expect(yaml).to receive(:recursive_symbolize_keys!)
        Tenon::I18nLookup.fields
      end
    end

    context "when the file doens't exist" do
      before do
        File.stub(:exist?) { false }
      end

      it 'should return an empty set of data' do
        expect(Tenon::I18nLookup.fields).to eq(tables: {})
      end
    end
  end
end
