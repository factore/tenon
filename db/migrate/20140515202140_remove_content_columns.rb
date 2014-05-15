class RemoveContentColumns < ActiveRecord::Migration
  def change
    remove_column :tenon_pages, :content
    remove_column :tenon_posts, :content
  end
end
