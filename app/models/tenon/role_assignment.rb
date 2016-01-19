module Tenon
  class RoleAssignment < Tenon::ApplicationRecord
    belongs_to :user
    belongs_to :role, class_name: 'Tenon::Role'
  end
end
