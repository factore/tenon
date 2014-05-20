class RemovePublishedFeldFromTenonPages < ActiveRecord::Migration
  def change
    remove_column :tenon_pages, :published
  end
end
