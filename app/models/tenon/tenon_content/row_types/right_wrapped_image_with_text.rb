module Tenon
  module TenonContent
    module RowTypes
      class RightWrappedImageWithText < TenonContent::RowTypes::Base
        class << self
          def add_pieces_to(row)
            if row.pieces.empty?
              row.pieces.build(piece_type: 'Image', position: 0, size: 'four')
              row.pieces.build(piece_type: 'Text', position: 1, size: 'eight')
            end
          end
        end
      end
    end
  end
end
