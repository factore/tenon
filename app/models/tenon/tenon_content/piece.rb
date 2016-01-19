module Tenon
  module TenonContent
    class Piece < Tenon::ApplicationRecord
      self.table_name = 'tenon_tenon_content_pieces'
      attr_reader :sizes, :styles

      def sizes
        # to translate between the stored piece size in words and a number for math
        {
          :one => 1.0,
          :two => 2.0,
          :three => 3.0,
          :four => 4.0,
          :five => 5.0,
          :six => 6.0,
          :seven => 7.0,
          :eight => 8.0,
          :nine => 9.0,
          :ten => 10.0,
          :eleven => 11.0,
          :twelve => 12.0
        }
      end

      def styles
        Hash[(1..10).map{|n| ["x#{n*200}", (n*200).to_s]}]
      end

      # Scopes, attachments, etc.
      has_asset :image, styles: {
        x2000: '2000>',
        x1800: '1800>',
        x1600: '1600>',
        x1400: '1400>',
        x1200: '1200>',
        x1000: '1000>',
        x800: '800>',
        x600: '600>',
        x400: '400>',
        x200: '200>'
      }

      # Relationships
      belongs_to :row, class_name: '::Tenon::TenonContent::Row'
    end
  end
end
