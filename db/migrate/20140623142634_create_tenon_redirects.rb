class CreateTenonRedirects < ActiveRecord::Migration
  def change
    create_table :tenon_redirects do |t|
      t.string :in
      t.string :out
      t.integer :list_order, default: 0
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
