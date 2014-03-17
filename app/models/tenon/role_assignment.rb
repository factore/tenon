module Tenon
  class RoleAssignment < ActiveRecord::Base
    belongs_to :user
    belongs_to :role, class_name: 'Tenon::Role'
  end
end
