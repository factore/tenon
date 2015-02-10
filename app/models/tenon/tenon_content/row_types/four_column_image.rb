module Tenon
  module TenonContent
    module RowTypes
      class FourColumnImage < TenonContent::RowTypes::Base
        class << self
          def add_pieces_to(row)
            if row.pieces.empty?
              row.pieces.build(piece_type: 'Image', position: 0, size: 'three')
              row.pieces.build(piece_type: 'Image', position: 1, size: 'three')
              row.pieces.build(piece_type: 'Image', position: 2, size: 'three')
              row.pieces.build(piece_type: 'Image', position: 3, size: 'three')
            end
          end
        end
      end
    end
  end
end
