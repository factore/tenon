module Tenon
  class TenonCallout < ActiveRecord::Base
    # Scopes, attachments, etc.
    include Tenon::Reorderable
    default_scope { order(:list_order) }

    # Validations
    validates_presence_of :title, :icon
    validates_uniqueness_of :title
    # Relationships

    def self.published
      where(published: true)
    end
  end
end
