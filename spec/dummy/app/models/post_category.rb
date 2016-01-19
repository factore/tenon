class PostCategory < ApplicationRecord
  has_and_belongs_to_many :posts, class_name: 'Post'
  validates_uniqueness_of :title
  validates_presence_of :title
end
