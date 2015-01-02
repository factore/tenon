module Tenon
  module TenonContent
    class Piece < ActiveRecord::Base
      self.table_name = 'tenon_tenon_content_pieces'
      attr_reader :max_width, :sizes, :styles

      def max_width
        1200
      end

      def sizes
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
        Hash[(1..12).map{|n| [sizes.key(n), (max_width/12*n).to_s]}]
      end

      # Scopes, attachments, etc.
      has_asset :image, styles: {
        twelve: '1920>',
        eleven: '1760>',
        ten: '1600>',
        nine: '1440>',
        eight: '1280>',
        seven: '1120>',
        six: '960>',
        five: '800>',
        four: '640>',
        three: '480>',
        two: '320>',
        one: '160>'
      }

      # Relationships
      belongs_to :row, class_name: '::Tenon::TenonContent::Row'
    end
  end
end
