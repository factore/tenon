module Tenon
  module TenonContent
    module RowTypes
      class FourColumnText < TenonContent::RowTypes::Base
        class << self
          def add_pieces_to(row)
            if row.pieces.empty?
              row.pieces.build(piece_type: 'Text', position: 0, size: 'three')
              row.pieces.build(piece_type: 'Text', position: 1, size: 'three')
              row.pieces.build(piece_type: 'Text', position: 2, size: 'three')
              row.pieces.build(piece_type: 'Text', position: 3, size: 'three')
            end
          end
        end
      end
    end
  end
end
