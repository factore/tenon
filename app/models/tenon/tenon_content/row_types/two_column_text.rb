module Tenon
  class TenonContent::RowTypes::TwoColumnText < TenonContent::RowTypes::Base
    class << self
      def add_pieces_to(row)
        if row.pieces.empty?
          row.pieces.build(:piece_type => 'Text', :position => 0)
          row.pieces.build(:piece_type => 'Text', :position => 1)
        end
      end
    end
  end
end