Rails.application.routes.draw do
  resources :pages, only: [:show]

  mount Tenon::Engine => '/tenon'
end


Tenon::Engine.routes.draw do
  resources :menus 
end
