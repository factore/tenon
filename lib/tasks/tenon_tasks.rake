namespace :tenon do
  desc "Regenerate all Asset styles"
  task :regenerate_asset_styles  => :environment do
    Tenon::Asset.all.each{ |a| a.attachment.reprocess! }
  end
end