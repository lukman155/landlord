Rails.application.routes.draw do
  devise_for :users
  resources :properties do
    resources :rooms do
      get 'rooms_by_type', on: :member
    end
  end
  resources :rentals, only: [:index, :show]
  
  namespace :users do
    resource :profile, only: [:show, :edit, :update]
  end
  
  post 'payments/webhook', to: 'payments#webhook'
  match 'payments/initialize', to: 'payments#initialize_transaction', via: [:get, :post]
  match 'payments/callback', to: 'payments#callback', via: [:get, :post]
  root "properties#index"
  get 'about-us', to: 'supports#about'
  get 'how-to-use', to: 'supports#how'
end