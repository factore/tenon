require 'test_helper'
include ActionDispatch::TestProcess

connection = ActiveRecord::Base.connection
connection.drop_table :dogs rescue nil
connection.create_table :dogs do |t|
  # Nada
end

class Dog < ActiveRecord::Base
  has_asset :avatar, styles: { dog_size: '250x250#' }
end

module Tenon
  class HasAssetTest < ActiveSupport::TestCase
    def dog
      @dog ||= Dog.new
    end

    %i(avatar_join avatar avatar= avatar_id=).each do |meth|
      test ".has_asset should define #{meth}" do
        assert dog.respond_to?(meth)
      end
    end

    test 'defined method should be nil when not yet set' do
      refute dog.avatar
    end

    test 'defined method should be Tenon::ProxyAttachment when set' do
      dog.avatar = fixture_file_upload('files/test.png')
      assert_equal dog.avatar.class, Tenon::ProxyAttachment
    end

    test 'original attachment includes a dog_size style' do
      dog.avatar = fixture_file_upload('files/test.png')
      styles = dog.avatar.attachment.styles.keys
      assert_includes styles, :dog_avatar_dog_size
    end
  end
end
