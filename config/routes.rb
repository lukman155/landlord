Rails.application.routes.draw do
  devise_for :users
  resources :properties
  namespace :users do
    resource :profile, only: [:show, :edit, :update]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "properties#index"
end
