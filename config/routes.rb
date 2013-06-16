NwkmExpenser::Application.routes.draw do
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :tags

  root to: 'static_pages#home'

  match '/signup',  to: 'users#new'
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy'
end
