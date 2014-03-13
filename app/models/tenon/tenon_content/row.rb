module Tenon
  class TenonContent::Row < ActiveRecord::Base
    self.table_name = 'tenon_tenon_content_rows'

    # Scopes, attachments, etc.
    include Tenon::Reorderable
    default_scope -> { order(:list_order) }

    # Validations

    # Relationships
    belongs_to :item
    has_many :pieces, -> { order 'position' }, :class_name => 'TenonContent::Piece', :dependent => :destroy

    # Nested
    accepts_nested_attributes_for :pieces

    def set_row_type(row_type)
      self.row_type = row_type
      build_pieces
    end

    def row_type_class
      "Tenon::TenonContent::RowTypes::#{row_type}".constantize
    end

    private

    def build_pieces
      row_type_class.add_pieces_to(self)
    end
  end
end