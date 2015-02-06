class Menu < ActiveRecord::Base
  # Scopes, attachments, etc.
  has_history

  # Validations

  # Relationships
  has_many :menu_items
  accepts_nested_attributes_for :menu_items,
    allow_destroy: true
end
