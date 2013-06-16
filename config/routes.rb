NwkmExpenser::Application.routes.draw do
  resources :users, only: [:show, :edit, :update]
  resources :sessions, only: [:new, :create, :destroy]
  resources :tags, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :accounts
  resources :contacts

  root to: 'static_pages#home'

  match '/signup',  to: 'users#new'
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy'
end
