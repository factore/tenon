module Tenon
  class PostCategory < ActiveRecord::Base
    has_and_belongs_to_many :posts, class_name: 'Tenon::Post'
    validates_uniqueness_of :title
    validates_presence_of :title
  end
end
