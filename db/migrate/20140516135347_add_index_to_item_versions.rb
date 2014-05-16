class AddIndexToItemVersions < ActiveRecord::Migration
  def change
    add_index :tenon_item_versions, [:item_id, :item_type]
  end
end
