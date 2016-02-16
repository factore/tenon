module Tenon
  module TenonContent
    module RowTypes
      class FourColumnImage < TenonContent::RowTypes::Base
        class << self
          def add_pieces_to(row)
            if row.pieces.empty?
              row.pieces.build(piece_type: 'Image', position: 0, size: 3)
              row.pieces.build(piece_type: 'Image', position: 1, size: 3)
              row.pieces.build(piece_type: 'Image', position: 2, size: 3)
              row.pieces.build(piece_type: 'Image', position: 3, size: 3)
            end
          end
        end
      end
    end
  end
end
