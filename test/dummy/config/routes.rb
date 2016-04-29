# Front End
Rails.application.routes.draw do
  resources :pages, only: [:show]

  mount Tenon::Engine => '/tenon'
end

# Back End, i.e. the Tenon UI
Tenon::Engine.routes.draw do
  devise_for :users, controllers: { sessions: 'devise/sessions', passwords: 'devise/passwords' }
  resources :users, except: [:show] do
    get 'approve', on: :member
  end


  resources :comments, only: [:index, :destroy] do
    get 'toggle_approved', on: :member
  end

  resources :contacts, only: [:index, :destroy] do
    get 'toggle_read', on: :member
    get 'toggle_replied', on: :member
  end

  resources :events, except: [:show]

  resources :galleries, except: [:show] do
    post 'reorder', on: :collection
  end

  resources :pages do
    post 'reorder', on: :collection
  end

  resources :posts do
    post :reorder, on: :collection
  end

  resources :post_categories

  resource :settings, only: [:show, :update]

  resources :redirects do
    post 'reorder', on: :collection
    get 'toggle_active', on: :member
  end
end
