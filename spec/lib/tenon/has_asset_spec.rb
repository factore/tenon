require 'spec_helper'
include ActionDispatch::TestProcess

connection = ActiveRecord::Base.connection
connection.drop_table :dogs rescue nil
connection.create_table :dogs do |t|
  # Nada
end

class Dog < ActiveRecord::Base
  has_asset :avatar, :styles => { :dog_size => '250x250#' }
end

describe Tenon::HasAsset do
  let(:dog) { Dog.new }
  context '.has_asset' do
    %i{avatar_join avatar avatar= avatar_id=}.each do |meth|
      it "should define ##{meth}" do
        expect(dog).to respond_to(meth)
      end
    end
  end

  context '#avatar' do
    context 'when no avatar has been set' do
      it 'should be nil' do
        expect(dog.avatar).to be_nil
      end
    end

    context 'when an avatar has been set on an unsaved dog' do
      before do
        dog.avatar = fixture_file_upload('/files/test.png')
      end

      it 'should be a Tenon::ProxyAttachment' do
        expect(dog.avatar).to be_a(Tenon::ProxyAttachment)
      end

      it 'should include a dog_size style on the original attachment' do
        styles = dog.avatar.attachment.styles.keys
        expect(styles).to include(:dog_avatar_dog_size)
      end
    end
  end
end
