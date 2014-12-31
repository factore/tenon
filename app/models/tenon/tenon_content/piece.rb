module Tenon
  module TenonContent
    class Piece < ActiveRecord::Base
      self.table_name = 'tenon_tenon_content_pieces'

      # Scopes, attachments, etc.
      has_asset :image, styles: {
        wrap: '400',
        half: '600',
        full: '1400',

        twelve: '1205>',
        twelve_desktop: '1205>',
        twelve_laptop: '726>',
        twelve_tablet: '662>',
        twelve_mobile: '',

        eleven: '1102>',
        eleven_laptop: '664>',
        eleven_tablet: '606>',
        elevent_mobile: '',

        ten: '999>',
        ten_laptop: '602>',
        ten_tablet: '549>',
        ten_mobile: '',

        nine: '896>',
        nine_laptop: '540>',
        nine_tablet: '493>',
        nine_mobile: '',

        eight: '794>',
        eight_laptop: '478>',
        eight_tablet: '436>',
        eight_mobile: '',

        seven: '691>',
        seven_laptop: '416>',
        seven_tablet: '380>',
        seven_mobile: '',

        six: '588>',
        six_laptop: '354>',
        six_tablet: '323>',
        six_mobile: '',

        five: '485>',
        five_laptop: '293>',
        five_tablet: '267>',
        five_mobile: '',

        four: '383>',
        four_laptop: '231>',
        four_tablet: '210>',
        four_mobile: '',

        three: '280>',
        three_laptop: '169>',
        three_tablet: '154>',
        three_mobile: '',

        two: '177>',
        two_laptop: '107>',
        two_tablet: '97>',
        two_mobile: '',

        one: '74>',
        one_laptop: '45>',
        one_tablet: '41>',
        one_mobile: ''
      }

      # Relationships
      belongs_to :row, class_name: '::Tenon::TenonContent::Row'
    end
  end
end
