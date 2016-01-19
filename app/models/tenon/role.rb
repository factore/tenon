module Tenon
  class Role < Tenon::ApplicationRecord
    has_many :role_assignments
    has_many :users, through: :role_assignments

    validates :title, presence: true
  end
end
