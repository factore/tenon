module Tenon
  class Styleguide
    include ActiveModel::Model
    attr_accessor :text, :number
    # tenon_content :content, i18n: true

    def initialize(attributes={})
      super
    end
  end
end
