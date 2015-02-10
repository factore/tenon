class MenuItem < ActiveRecord::Base
  # Scopes, attachments, etc.
  has_history
  include Tenon::Reorderable
  default_scope { order('menu_items.list_order') }
  tenon_content :top_content
  tenon_content :bottom_content

  # Validations

  # Relationships
  belongs_to :menu

  private
end
