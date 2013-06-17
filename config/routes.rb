NwkmExpenser::Application.routes.draw do
  resources :users, only: [:show, :edit, :update]
  resources :sessions, only: [:new, :create, :destroy]
  resources :tags, except: :show
  resources :accounts
  resources :contacts
  resources :transactions

  root to: 'static_pages#home'

  match '/login',  to: 'sessions#new'
  match '/logout', to: 'sessions#destroy'
end
