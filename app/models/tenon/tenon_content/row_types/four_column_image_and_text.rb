module Tenon
  module TenonContent
    module RowTypes
      class FourColumnImageAndText < TenonContent::RowTypes::Base
        class << self
          def add_pieces_to(row)
            if row.pieces.empty?
              row.pieces.build(piece_type: 'Image', position: 0, size: 'three')
              row.pieces.build(piece_type: 'Text', position: 1, size: 'three')
              row.pieces.build(piece_type: 'Image', position: 2, size: 'three')
              row.pieces.build(piece_type: 'Text', position: 3, size: 'three')
              row.pieces.build(piece_type: 'Image', position: 4, size: 'three')
              row.pieces.build(piece_type: 'Text', position: 5, size: 'three')
              row.pieces.build(piece_type: 'Image', position: 6, size: 'three')
              row.pieces.build(piece_type: 'Text', position: 7, size: 'three')
            end
          end
        end
      end
    end
  end
end
