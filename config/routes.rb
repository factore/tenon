Tenon::Engine.routes.draw do
  devise_for :users, class_name: "Tenon::User", module: :devise

  resources :item_versions, only: [:create, :show, :new, :index]

  resources :assets, path: 'asset-library', except: [:show] do
    post 'encode_notify', :on => :collection
    get :crop, :on => :member
  end

  resources :item_assets, :except => [:index, :show]

  resources :users, :except => [:show] do
    get 'approve', :on => :member
  end

  resources :styleguides, :only => [:index]

  root :to => Tenon.config.routing.root
end
