namespace :deploy do
  desc 'Deploy Tenon'
  task :tenon, roles: :db do
    run "cd #{current_release}; bundle exec rake tenon:deploy RAILS_ENV=production PASSWORD=#{ENV['PASSWORD']}"
  end
end
