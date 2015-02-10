module Tenon
  module TenonContent
    module RowTypes
      class SixColumnImage < TenonContent::RowTypes::Base
        class << self
          def add_pieces_to(row)
            if row.pieces.empty?
              row.pieces.build(piece_type: 'Image', position: 0, size: 'two')
              row.pieces.build(piece_type: 'Image', position: 1, size: 'two')
              row.pieces.build(piece_type: 'Image', position: 2, size: 'two')
              row.pieces.build(piece_type: 'Image', position: 3, size: 'two')
              row.pieces.build(piece_type: 'Image', position: 4, size: 'two')
              row.pieces.build(piece_type: 'Image', position: 5, size: 'two')
            end
          end
        end
      end
    end
  end
end
