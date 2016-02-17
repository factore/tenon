class Post < ApplicationRecord
  # Scopes, Attachments, etc.
  date_time_attribute :publish_at

  default_scope { order(publish_at: :desc) }

  scope :posted, -> { where('publish_at <= ?', Time.now) }
  scope :for_archive, ->(year, month) { where(Post.for_archive_conditions(year, month)) }

  tenon_content :content, i18n: true
  has_history includes: [:content_tenon_content_rows]
  can_have_comments

  # Relationships
  has_and_belongs_to_many :post_categories, class_name: 'PostCategory'
  belongs_to :user

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
