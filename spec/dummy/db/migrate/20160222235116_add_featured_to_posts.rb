class AddFeaturedToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :featured, :boolean
  end
end
