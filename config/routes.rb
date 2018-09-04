Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "accounts#new"
  resources :accounts
  namespace :api do
    resources :images, only: [:show, :create, :update, :destroy]
    get "/posts/list", to: "posts#list"
    post "/signup", to: "accounts#create"
  end
end
