module Tenon
  class Role < ActiveRecord::Base
    has_many :role_assignments
    has_many :users, through: :role_assignments

    validates :title, :presence => true
  end
end