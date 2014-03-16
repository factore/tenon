module Tenon
  class TenonContent::RowTypes::FullWidthText < TenonContent::RowTypes::Base
    class << self
      def add_pieces_to(row)
        if row.pieces.empty?
          row.pieces.build(piece_type: 'Text', position: 0)
        end
      end
    end
  end
end
