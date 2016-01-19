class RemoveTenonUsers < ActiveRecord::Migration[5.0]
  def change
    drop_table :tenon_users
    drop_table :tenon_roles
    drop_table :tenon_role_assignments
  end
end
