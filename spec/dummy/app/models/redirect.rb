class Redirect < ActiveRecord::Base
  # Scopes, attachments, etc.
  has_history
  include Tenon::Reorderable

  default_scope { order('tenon_redirects.list_order') }
  scope :active, -> { where(active: true) }

  # Validations
  validates_presence_of :in, :out
  validates_uniqueness_of :in

  def toggle_active!
    self.active = self.active? ? false : true
    save
  end
end
