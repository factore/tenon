module Tenon
  class TenonContent::Piece < ActiveRecord::Base
    self.table_name = 'tenon_tenon_content_pieces'

    # Scopes, attachments, etc.
    has_asset :image, styles: { wrap: '400', half: '600', full: '1400' }

    # Relationships
    belongs_to :row, class_name: '::Tenon::TenonContent::Row'
  end
end
