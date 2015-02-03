module Tenon
  module TenonContent
    module RowTypes
      class SixColumnImageAndText < TenonContent::RowTypes::Base
        class << self
          def add_pieces_to(row)
            if row.pieces.empty?
              row.pieces.build(piece_type: 'Image', position: 0, size: 'two')
              row.pieces.build(piece_type: 'Text', position: 1, size: 'two')
              row.pieces.build(piece_type: 'Image', position: 2, size: 'two')
              row.pieces.build(piece_type: 'Text', position: 3, size: 'two')
              row.pieces.build(piece_type: 'Image', position: 4, size: 'two')
              row.pieces.build(piece_type: 'Text', position: 5, size: 'two')
              row.pieces.build(piece_type: 'Image', position: 6, size: 'two')
              row.pieces.build(piece_type: 'Text', position: 7, size: 'two')
              row.pieces.build(piece_type: 'Image', position: 8, size: 'two')
              row.pieces.build(piece_type: 'Text', position: 9, size: 'two')
              row.pieces.build(piece_type: 'Image', position: 10, size: 'two')
              row.pieces.build(piece_type: 'Text', position: 11, size: 'two')
            end
          end
        end
      end
    end
  end
end
