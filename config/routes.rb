Rails.application.routes.draw do
  devise_for :users
  resources :properties do
    resources :rooms do
      get 'rooms_by_type', on: :member
    end
  end
  
  namespace :users do
    resource :profile, only: [:show, :edit, :update]
  end
  
  match 'payments/initialize', to: 'payments#initialize_transaction', via: [:get, :post]
  match 'payments/callback', to: 'payments#callback', via: [:get, :post]
  root "properties#index"
end