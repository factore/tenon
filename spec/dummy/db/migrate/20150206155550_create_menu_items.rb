class CreateMenuItems < ActiveRecord::Migration
  def change
    create_table :menu_items do |t|
      t.integer :menu_id
      t.string :title
      t.integer :list_order

      t.timestamps
    end
  end
end
