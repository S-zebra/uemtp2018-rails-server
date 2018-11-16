Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :accounts, except: [:new]
  get "/signup", to: "accounts#new"

  get "/signin", to: "sessions#new"
  post "/signin", to: "sessions#create"

  # resources :tokens, only: [:index, :create, :destroy]

  namespace :api, {format: "json"} do
    namespace :v1 do
      resources :images, only: [:show, :create, :update, :destroy]
      resources :posts, except: [:new]
      resources :locations, only: [:index, :create]
      get "/accounts/available", to: "accounts#available?"
      post "/posts/locations", to: "posts#add_location"
    end
  end

  root "accounts#new"
end
