class Tenon::Redirect < ActiveRecord::Base
  # Scopes, attachments, etc.
  has_history
  include Tenon::Reorderable

  default_scope { order('tenon_redirects.list_order') }
  scope :active, -> { where('redirects.active = ?', true) }

  # Validations
  validates_presence_of :in, :out

end
