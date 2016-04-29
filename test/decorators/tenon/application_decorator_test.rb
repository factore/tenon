require 'test_helper'

class TestObj
end

class TestObjSerializer
end

module Tenon
  class ApplicationDecoratorTest < ActiveSupport::TestCase
    def build(obj = default_obj)
      ApplicationDecorator.new(obj)
    end

    def default_obj
      @default_obj ||= stub_everything
    end

    test '#edit_path calls url_for' do
      ad = build
      ad.h.expects(:url_for).with([:edit, default_obj])
      ad.edit_path
    end

    test '#published? returns true when object responds to publish_at and
          publish_at is in the past' do
      ad = build(stub(publish_at: Time.now - 1.second))
      assert ad.published?
    end

    test '#published? returns false when object responds to publish_at and
          publish_at is in the future' do
      ad = build(stub(publish_at: Time.now + 1.second))
      refute ad.published?
    end

    test '#published? returns true when object responds to published and
          published is true' do
      ad = build(stub(published: true))
      assert ad.published?
    end

    test '#published? returns false when object responds to published and
         published is false' do
      ad = build(stub(published: false))
      refute ad.published?
    end

    test '#published? returns true when object does not respond to published
          or publish_at' do
      ad = build(stub)
      assert ad.published?
    end

    test '#serializer_class infers the correct serializer class' do
      assert_equal build(TestObj.new).serializer_class, TestObjSerializer
    end
  end
end
