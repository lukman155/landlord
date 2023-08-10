Rails.application.routes.draw do
  devise_for :users
  resources :properties do
    resources :rooms
  end
  
  namespace :users do
    resource :profile, only: [:show, :edit, :update]
  end
  
  get 'initialize_payment', to: 'payments#initialize_transaction'
  post 'payment_callback', to: 'payments#callback'
  root "properties#index"
end