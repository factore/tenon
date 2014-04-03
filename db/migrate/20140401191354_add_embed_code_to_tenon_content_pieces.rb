class AddEmbedCodeToTenonContentPieces < ActiveRecord::Migration
  def change
    add_column :tenon_tenon_content_pieces, :embed_code, :text
  end
end
