class RemoveUniqueKeyFromTenonPages < ActiveRecord::Migration
  def change
    remove_column :tenon_pages, :unique_key, :string
  end
end
