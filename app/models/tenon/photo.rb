module Tenon
  class Photo < ActiveRecord::Base
    belongs_to :gallery, class_name: 'Gallery', foreign_key: 'gallery_id', inverse_of: :photos
    has_asset :file, styles: {
      original: '800x800>'
    }
    default_scope { order(:list_order) }
  end
end
