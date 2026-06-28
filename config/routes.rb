Rails.application.routes.draw do
  devise_for :users
  resources :tasks
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/users", to: "users#index"
  get "/tasks", to: "tasks#index"
  root to: "tasks#index"
end