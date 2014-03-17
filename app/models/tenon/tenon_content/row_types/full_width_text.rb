module Tenon
  class TenonContent::RowTypes::FullWidthText < TenonContent::RowTypes::Base
    class << self
      def add_pieces_to(row)
        row.pieces.build(piece_type: 'Text', position: 0) if row.pieces.empty?
      end
    end
  end
end
