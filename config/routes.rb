Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :accounts, except: [:new]
  get "/signup", to: "accounts#new"

  get "/signin", to: "sessions#new"
  post "/signin", to: "sessions#create"

  # resources :tokens, only: [:index, :create, :destroy]

  namespace :api do
    resources :images, only: [:show, :create, :update, :destroy]
    get "/posts/list", to: "posts#list"
  end

  root "accounts#new"
end
