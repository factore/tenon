# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
['Super Admin', 'Admin'].each { |r| Tenon::Role.find_or_create_by(title: r) }

%w(admin super_admin).each do |role|
  password = ENV['PASSWORD'].blank? ? role : ENV['PASSWORD']
  user = Tenon::User.new(:password => password, :password_confirmation => password, :email => "#{role}@factore.ca")
  user.approved = true
  user.roles << Tenon::Role.find_by(title: role.humanize.titleize)
  if user.save
    puts "#{role.humanize.titleize} user created with username: #{user.email}, password: #{password}"
  else
    puts "#{role.humanize.titleize} user not saved because #{user.errors.full_messages.to_sentence}.  Make sure your database is set up correctly."
  end
end

# Get config/sitemap.yml
# require 'yaml'
# classes = YAML.load(File.new("#{Rails.root}/config/sitemap.yml"))

# # Default Pages from config/sitemap.yml
# puts '\n============\nBUILDING PAGES'
# content = '<p>Edit this page in Tenon</p>'
# classes['Pages'].each do |page, subpages|
#   p = Tenon::Page.new(:title => page, :slug => page.parameterize, :key => page.parameterize, :content => content, :published => true)
#   puts p.save ? "Created #{page}" : "Errors on #{page}: " + p.errors.map { |e| "#{e[0]} #{e[1]}" }.join(', ')
#   # Build the Subpages
#   if p.errors.blank?
#     subpages.each do |subpage, subsubpages|
#       subp = Page.new(:title => subpage, :slug => subpage.parameterize, :content => content, :parent => p, :published => true)
#       subp.published = true
#       puts subp.save ? "  - Created #{subpage}" : "Errors on #{subpage}: " + subp.errors.map { |e| "#{e[0]} #{e[1]}" }.join(', ')
#     end unless subpages.blank?
#   end
# end

# # Default Post Categories from config/sitemap.yml
# puts '\n============\nPOST CATEGORIES'
# classes['PostCategory'].each do |category|
#   pc = Tenon::PostCategory.new(:title => category)
#   puts pc.save ? "Created #{category}" : "Errors on #{category}: " + pc.errors.map { |e| "#{e[0]} #{e[1]}" }.join(', ')
# end
