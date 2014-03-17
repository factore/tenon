module Tenon
  class Post < ActiveRecord::Base
    # Scopes, Attachments, etc.
    scope :posted, -> { where('created_at <= ? AND published = ?', Time.now, true) }
    scope :for_archive, ->(year, month) { where(Post.for_archive_conditions(year, month)) }
    default_scope { order('created_at DESC') }
    tenon_content :content

    # Relationships
    has_and_belongs_to_many :post_categories
    can_have_comments

    # Validations
    validates_presence_of :title

    def to_param
      "#{id}-#{title.parameterize}"
    end

    # previous and next posts for mobile post nav
    def next
      Post.posted.where('created_at > ?', created_at).last
    end

    def previous
      Post.posted.where('created_at < ?', created_at).first
    end

    def posted?
      published && created_at <= Time.now
    end
  end
end
