class CreateTenonItemVersions < ActiveRecord::Migration
  def change
    create_table :tenon_item_versions do |t|
      t.integer :item_id
      t.string :item_type
      t.binary :serialized_item
      t.string :title
      t.string :save_type
      t.integer :creator_id

      t.timestamps
    end
  end
end
