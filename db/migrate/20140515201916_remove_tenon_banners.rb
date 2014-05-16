class RemoveTenonBanners < ActiveRecord::Migration
  def change
    drop_table :tenon_banners
  end
end
