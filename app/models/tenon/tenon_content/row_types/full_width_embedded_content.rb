module Tenon
  module TenonContent
    module RowTypes
      class FullWidthEmbeddedContent < TenonContent::RowTypes::Base
        class << self
          def add_pieces_to(row)
            row.pieces.build(piece_type: 'EmbeddedContent', position: 0, size: 12) if row.pieces.empty?
          end
        end
      end
    end
  end
end
