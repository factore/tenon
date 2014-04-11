# This migration comes from tenon (originally 20140401191354)
class AddEmbedCodeToTenonContentPieces < ActiveRecord::Migration
  def change
    add_column :tenon_tenon_content_pieces, :embed_code, :text
  end
end
