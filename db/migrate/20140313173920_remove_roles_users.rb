class RemoveRolesUsers < ActiveRecord::Migration
  def change
    drop_table :tenon_roles_users
  end
end
