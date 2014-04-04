module Tenon
  class Comment < ActiveRecord::Base
    include Humanizer
    require_human_on :create

    validates_presence_of :commentable, :author, :author_email, :content
    validates_format_of :author_email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

    belongs_to :commentable, polymorphic: true

    attr_accessor :subscribe, :controller

    default_scope { order('created_at DESC') }
    scope :approved, -> { where(approved: true) }
    scope :unapproved, -> { where(approved: false) }

    # Comment/uncomment this to turn off/on moderation
    # before_save :approve

    after_save :handle_subscribers

    def self.create_comment(object, session)
      session.blank? ? Comment.new(commentable_type: object.class.to_s, commentable_id: object.id) : Comment.new(session)
    end

    def approve!
      self.approved = true
      save
    end

    def unapprove!
      self.approved = false
      save
    end

    def approve
      self.approved = true
    end

    private

    def handle_subscribers
      # create subscriber
      CommentSubscriber.create(commentable: commentable, email: author_email) if subscribe.to_i == 1

      # notify subscribers
      if approved? && commentable.respond_to?(:subscribers)
        commentable.subscribers.each { |subscriber| CommentMailer.comment_notification(subscriber.email, self).deliver }
      end
    end
  end
end
