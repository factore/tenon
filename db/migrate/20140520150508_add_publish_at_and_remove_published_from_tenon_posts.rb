class AddPublishAtAndRemovePublishedFromTenonPosts < ActiveRecord::Migration
  def change
    add_column :tenon_posts, :publish_at, :datetime
    remove_column :tenon_posts, :published
  end
end
