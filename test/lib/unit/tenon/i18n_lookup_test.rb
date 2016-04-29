require 'test_helper'

class TestObject
end

class TestObjectDecorator < Draper::Decorator
end

module Tenon
  class I18nLookupTest < ActiveSupport::TestCase
    test '.new when given a decorator assigns the underlying class' do
      i = I18nLookup.new(TestObjectDecorator.new(TestObject.new).class)
      assert_equal i.instance_variable_get('@klass'), TestObject.to_s
    end

    test '.new when given a non-decorator class assigns that class' do
      i = Tenon::I18nLookup.new(String)
      assert_equal i.instance_variable_get('@klass'), String.to_s
    end

    test "#fields returns an empty array when there's no match" do
      I18nLookup.stubs(:fields).returns(tables: {})
      assert_equal Tenon::I18nLookup.new(String).fields, []
    end

    test "#fields returns the field names when there's a match" do
      I18nLookup.stubs(:fields).returns(tables: { strings: %w(a b c) })
      assert_equal Tenon::I18nLookup.new(String).fields, %w(a b c)
    end

    def reset_fields
      I18nLookup.class_variable_set :@@fields, nil
    end

    test '.fields when the YAML file exists loads the file' do
      reset_fields
      File.stubs(:exist?).returns(true)
      YAML.expects(:load).returns(tables: {})
      I18nLookup.fields
    end

    test '.fields when the YAML file exists symbolizes the keys' do
      reset_fields
      yaml = stub
      YAML.stubs(:load).returns(yaml)
      yaml.expects(:recursive_symbolize_keys!)
      I18nLookup.fields
    end

    test '.fields when the YAML file does not exist returns an empty set' do
      reset_fields
      File.stubs(:exist?).returns(false)
      assert_equal I18nLookup.fields, tables: {}
    end
  end
end
