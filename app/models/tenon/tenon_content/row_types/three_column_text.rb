module Tenon
  module TenonContent
    module RowTypes
      class ThreeColumnText < TenonContent::RowTypes::Base
        class << self
          def add_pieces_to(row)
            if row.pieces.empty?
              row.pieces.build(piece_type: 'Text', position: 0, size: 'four')
              row.pieces.build(piece_type: 'Text', position: 1, size: 'four')
              row.pieces.build(piece_type: 'Text', position: 2, size: 'four')
            end
          end
        end
      end
    end
  end
end
