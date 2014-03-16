module Tenon
  class TenonContent::RowTypes::FullWidthImage < TenonContent::RowTypes::Base
    class << self
      def add_pieces_to(row)
        if row.pieces.empty?
          row.pieces.build(piece_type: 'Image', position: 0)
        end
      end
    end
  end
end
