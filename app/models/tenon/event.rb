module Tenon
  class Event < ActiveRecord::Base
    # Scopes, attachments, etc.
    scope :published, -> { where(published: true) }
    scope :upcoming, -> { where(['ends_at > ?', Time.now]).order(:starts_at) }
    scope :past, -> { where(['ends_at < ?', Time.now]).order(:starts_at) }
    default_scope -> { order 'starts_at DESC' }
    tenon_content :description
    has_history includes: [:description_tenon_content_rows]

    # Validations
    validates_presence_of :title, :starts_at, :ends_at

    def self.on(year, month = nil, day = nil)
      fail ArgumentError, 'must pass a month to pass a day' if day && !month
      time = Time.mktime(year, month, day)
      # delta = day ? 1.day : month ? 1.month : year ? 1.year : fail
      if day
        delta = 1.day
      elsif month
        delta = 1.month
      elsif year
        delta = 1.year
      else
        fail
      end

      limit = time + delta

      where('starts_at > ? AND starts_at < ?', time, limit).order('starts_at')
    end

    def to_param
      "#{id}-#{title.parameterize}"
    end

    def next
      Event.published.where('starts_at > ?', starts_at).first
    end

    def previous
      Event.published.where('starts_at < ?', starts_at).last
    end
  end
end
