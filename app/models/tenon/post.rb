module Tenon
  class Post < ActiveRecord::Base
    # Scopes, Attachments, etc.
    default_scope { order('publish_at DESC') }
    scope :posted, -> { where('publish_at <= ?', Time.now) }
    scope :for_archive, ->(year, month) { where(Post.for_archive_conditions(year, month)) }
    tenon_content :content
    has_history includes: [:content_tenon_content_rows]

    # Relationships
    has_and_belongs_to_many :post_categories, class_name: 'Tenon::PostCategory'
    belongs_to :user
    can_have_comments

    # Validations
    validates_presence_of :title

    def to_param
      "#{id}-#{title.parameterize}"
    end

    # previous and next posts for mobile post nav
    def next
      Post.posted.where('publish_at > ?', publish_at).last
    end

    def previous
      Post.posted.where('publish_at < ?', publish_at).first
    end

    def posted?
      publish_at.present? ? publish_at <= Time.now : false
    end
  end
end
