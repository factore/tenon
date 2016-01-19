Tenon::Engine.routes.draw do
  resources :item_versions, only: [:create, :show, :new, :index]

  resources :assets, path: 'asset-library', except: [:show] do
    post 'encode_notify', :on => :collection
    get :crop, :on => :member
  end

  resources :item_assets, :except => [:index, :show]

  resources :styleguides, :only => [:index]

  root :to => Tenon.config.routing.root
end
