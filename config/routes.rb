Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :accounts
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"

  resources :tokens

  namespace :api do
    resources :images, only: [:show, :create, :update, :destroy]
    get "/posts/list", to: "posts#list"
  end

  root "accounts#new"
end
