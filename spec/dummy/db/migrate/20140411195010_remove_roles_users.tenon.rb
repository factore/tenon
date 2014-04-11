# This migration comes from tenon (originally 20140313173920)
class RemoveRolesUsers < ActiveRecord::Migration
  def change
    drop_table :tenon_roles_users
  end
end
