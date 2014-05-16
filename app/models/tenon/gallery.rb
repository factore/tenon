module Tenon
  class Gallery < ActiveRecord::Base
    include Tenon::Reorderable
    has_many :photos, inverse_of: :gallery
    accepts_nested_attributes_for :photos, allow_destroy: true, reject_if: ->(p) { p[:file_id].blank? }
    validates_presence_of :title
    validates_uniqueness_of :title
    default_scope { order('tenon_galleries.list_order') }
    has_history includes: [:photos]

    def self.find_with_photos(id)
      includes(:photos).order('tenon_photos.list_order').find(id)
    end
  end
end
