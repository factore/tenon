# This migration comes from tenon (originally 20140313173134)
class CreateTenonRoleAssignments < ActiveRecord::Migration
  def change
    create_table :tenon_role_assignments do |t|
      t.integer :user_id
      t.integer :role_id
    end
    add_index :tenon_role_assignments, :user_id
    add_index :tenon_role_assignments, :role_id
  end
end
