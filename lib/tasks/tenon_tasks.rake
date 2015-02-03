namespace :tenon do
  desc "Regenerate all Asset styles"
  task :regenerate_asset_styles  => :environment do
    total_assets = Tenon::Asset.all.count
    Tenon::Asset.all.each_with_index do |a, i|
      puts "(#{i+1}/#{total_assets}) #{a.attachment_file_name}"
      a.attachment.reprocess!
    end
  end
end