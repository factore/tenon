class RemoveTaggings < ActiveRecord::Migration
  def change
    remove_index "taggings", ["tag_id"]
    remove_index "taggings", ["taggable_id", "taggable_type", "context"]
    remove_index "taggings", ["tagger_id", "tagger_type"]

    drop_table "taggings"
    drop_table "tags"
  end
end
