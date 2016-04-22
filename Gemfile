source "https://rubygems.org"

# Declare your gem's dependencies in tenon.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use debugger
# gem 'debugger'

# Everything below is to get Rails 5.0.0.beta3 working

# activemodel-serializers-xml is needed for draper to work with Rails 5 for now
gem 'activemodel-serializers-xml', github: 'rails/activemodel-serializers-xml'

# need to use these edge versions for Rails 5 for now
gem 'rack', github: 'rack/rack'
gem 'draper', github: 'audionerd/draper', branch: 'rails5'
gem 'devise', github: 'plataformatec/devise'
gem 'client_side_validations', git: 'https://github.com/DavyJonesLocker/client_side_validations', branch: 'rails5'

gem 'webpack_rails', '~> 1.0.0.pre', github: 'SeanRoberts/webpack_rails', group: :development
