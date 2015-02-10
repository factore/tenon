module Tenon
  module TenonContent
    module RowTypes
      class FullWidthImage < TenonContent::RowTypes::Base
        class << self
          def add_pieces_to(row)
            row.pieces.build(piece_type: 'Image', position: 0, size: 'twelve') if row.pieces.empty?
          end
        end
      end
    end
  end
end
