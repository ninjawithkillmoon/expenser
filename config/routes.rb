NwkmExpenser::Application.routes.draw do
  resources :users, only: [:show, :edit, :update]
  resources :sessions, only: [:new, :create, :destroy]
  resources :tags, except: :show
  resources :accounts
  resources :contacts
  resources :transactions
  resources :transfers, only: [:new, :create]

  root to: 'static_pages#home'

  match '/assets/expense_report_data_pie',  to: 'javascripts#expense_report_data_pie'
  match '/assets/expense_report_data_bar',  to: 'javascripts#expense_report_data_bar'

  match '/login',  to: 'sessions#new'
  match '/logout', to: 'sessions#destroy'

  get ':controller(/:action(/:nav))'
end
