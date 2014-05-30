module Tenon
  module TenonContent
    module RowTypes
      class ThreeColumnImageAndText < TenonContent::RowTypes::Base
        class << self
          def add_pieces_to(row)
            if row.pieces.empty?
              row.pieces.build(piece_type: 'Image', position: 0, size: 'four')
              row.pieces.build(piece_type: 'Text', position: 1, size: 'four')
              row.pieces.build(piece_type: 'Image', position: 2, size: 'four')
              row.pieces.build(piece_type: 'Text', position: 3, size: 'four')
              row.pieces.build(piece_type: 'Image', position: 4, size: 'four')
              row.pieces.build(piece_type: 'Text', position: 5, size: 'four')
            end
          end
        end
      end
    end
  end
end
