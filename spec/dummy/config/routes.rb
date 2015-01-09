Rails.application.routes.draw do
  resources :pages, only: [:show]

  mount Tenon::Engine => '/tenon'
end
