class RemoveTenonCalloutsSubscribers < ActiveRecord::Migration[5.0]
  def change
    drop_table :tenon_tenon_callouts
    drop_table :tenon_subscribers
    drop_table :tenon_subscriber_groups
    drop_table :tenon_subscriber_group_members
  end
end
