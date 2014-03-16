module Tenon
  class TenonContent::RowTypes::LeftTextRightImage < TenonContent::RowTypes::Base
    class << self
      def add_pieces_to(row)
        if row.pieces.empty?
          row.pieces.build(piece_type: 'Text', position: 0, size: 'six')
          row.pieces.build(piece_type: 'Image', position: 1, size: 'six')
        end
      end
    end
  end
end
