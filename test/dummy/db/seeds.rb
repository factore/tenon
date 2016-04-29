['Super Admin', 'Admin'].each { |r| Role.find_or_create_by(title: r) }

%w(admin super_admin).each do |role|
  password = ENV['PASSWORD'].blank? ? role + '1234' : ENV['PASSWORD']
  user = User.new(password: password, password_confirmation: password, email: "#{role}@factore.ca")
  user.approved = true
  user.roles << Role.find_by(title: role.humanize.titleize)
  if user.save
    puts "#{role.humanize.titleize} user created with username: #{user.email}, password: #{password}"
  else
    puts "#{role.humanize.titleize} user not saved because #{user.errors.full_messages.to_sentence}.  Make sure your database is set up correctly."
  end
end
