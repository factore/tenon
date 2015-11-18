class DropDefaultTenonResources < ActiveRecord::Migration
  def change
    drop_table :tenon_comment_subscribers
    drop_table :tenon_comments
    drop_table :tenon_contacts
    drop_table :tenon_events
    drop_table :tenon_galleries
    drop_table :tenon_pages
    drop_table :tenon_photos
    drop_table :tenon_post_categories
    drop_table :tenon_post_categories_posts
    drop_table :tenon_posts
    drop_table :tenon_redirects
  end
end
