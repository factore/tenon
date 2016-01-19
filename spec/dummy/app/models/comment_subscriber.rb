class CommentSubscriber < ApplicationRecord
  validates_presence_of :email, :commentable
  validates_uniqueness_of :email, scope: [:commentable_id, :commentable_type]
  belongs_to :commentable, polymorphic: true
end
