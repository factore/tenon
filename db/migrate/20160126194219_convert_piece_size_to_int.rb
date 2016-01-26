class ConvertPieceSizeToInt < ActiveRecord::Migration[5.0]
  def change
    remove_column :tenon_tenon_content_pieces, :size
    add_column :tenon_tenon_content_pieces, :size, :integer
  end
end
