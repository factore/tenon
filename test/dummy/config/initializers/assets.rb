# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

if Rails.env.production?
  APP_FRONTEND_ASSET_PATH = 'app'
  TENON_FRONTEND_ASSET_PATH = 'tenon'

else
  APP_FRONTEND_ASSET_PATH = '/app-wp-bundle'
  TENON_FRONTEND_ASSET_PATH = '/tenon-wp-bundle'
end
