# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

Rails.application.config.assets.precompile += [
  'tenon-wp-bundle.js',
  'app-wp-bundle.js',
  'app.js',
  'tenon/tenon.js',
  'tenon-wp-bundle.css',
  'app-wp-bundle.css',
  'app.css',
  'tenon/tenon.css'
]

if Rails.env.production?
  APP_FRONTEND_ASSET_PATH = 'app'
  TENON_FRONTEND_ASSET_PATH = 'tenon/tenon'

else
  APP_FRONTEND_ASSET_PATH = '/app-wp-bundle'
  TENON_FRONTEND_ASSET_PATH = '/tenon-wp-bundle'
end
