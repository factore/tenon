module Tenon
  module TenonContent
    module RowTypes
      class SixColumnImageAndText < TenonContent::RowTypes::Base
        class << self
          def add_pieces_to(row)
            if row.pieces.empty?
              row.pieces.build(piece_type: 'Image', position: 0, size: 2)
              row.pieces.build(piece_type: 'Text', position: 1, size: 2)
              row.pieces.build(piece_type: 'Image', position: 2, size: 2)
              row.pieces.build(piece_type: 'Text', position: 3, size: 2)
              row.pieces.build(piece_type: 'Image', position: 4, size: 2)
              row.pieces.build(piece_type: 'Text', position: 5, size: 2)
              row.pieces.build(piece_type: 'Image', position: 6, size: 2)
              row.pieces.build(piece_type: 'Text', position: 7, size: 2)
              row.pieces.build(piece_type: 'Image', position: 8, size: 2)
              row.pieces.build(piece_type: 'Text', position: 9, size: 2)
              row.pieces.build(piece_type: 'Image', position: 10, size: 2)
              row.pieces.build(piece_type: 'Text', position: 11, size: 2)
            end
          end
        end
      end
    end
  end
end
