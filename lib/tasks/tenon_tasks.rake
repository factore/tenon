namespace :tenon do
  desc "Generate Asset responsive styles"
  task :generate_responsive_styles  => :environment do
    styles = [:x2000, :x1800, :x1600, :x1400, :x1200, :x1000, :x800, :x600, :x400, :x200]
    total_assets = Tenon::Asset.all.count
    Tenon::Asset.all.each_with_index do |a, i|
      print "(#{i+1}/#{total_assets}) #{a.attachment_file_name} "
      styles.each do |style|
        a.attachment.reprocess! style
        print '.'
        $stdout.flush
      end
      puts ''
    end
    puts 'Done!'
  end
end