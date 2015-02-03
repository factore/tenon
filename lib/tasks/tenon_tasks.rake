namespace :tenon do
  desc "Generate Asset responsive styles"
  task :generate_responsive_styles  => :environment do
    styles = [
      :tenon_tenon_content_piece_image_x2000,
      :tenon_tenon_content_piece_image_x1800,
      :tenon_tenon_content_piece_image_x1600,
      :tenon_tenon_content_piece_image_x1400,
      :tenon_tenon_content_piece_image_x1200,
      :tenon_tenon_content_piece_image_x1000,
      :tenon_tenon_content_piece_image_x800,
      :tenon_tenon_content_piece_image_x600,
      :tenon_tenon_content_piece_image_x400,
      :tenon_tenon_content_piece_image_x200
    ]

    item_assets = Tenon::ItemAsset.where(item_type: 'Tenon::TenonContent::Piece').pluck(:asset_id).uniq

    # only reprocess assets that are referenced by Pieces, and only do them once each even if they are referenced by multiple pieces
    Tenon::Asset.find(item_assets).each_with_index do |asset, i|
      print "(#{i+1}/#{item_assets.count}) #{asset.attachment_file_name} "
      styles.each do |style|
        asset.attachment.reprocess! style
        print '.'
        $stdout.flush
      end
      puts ''
    end
    puts 'Done!'
  end
end