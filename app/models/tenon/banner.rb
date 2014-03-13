module Tenon
  class Banner < ActiveRecord::Base
    # Scopes, attachments, etc.
    include Tenon::Reorderable
    default_scope { order(:list_order) }
    scope :published, -> { where(:published => true) }
    has_asset :file, :styles => { :original => '800x800>', :thumbnail => '300x300#' }

    # Validations
    validates_presence_of :title, :file_id
  end
end
