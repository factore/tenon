class AddStretchBooleanToTenonTenonContentPieces < ActiveRecord::Migration
  def change
    add_column :tenon_tenon_content_pieces, :stretch_to_fill, :boolean, default: false
    remove_column :tenon_tenon_content_pieces, :dimenstions
  end
end
