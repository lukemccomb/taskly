Rails.application.routes.draw do
  root "task_lists#index"
  get "signin" => "sessions#new", as: :signin
  get "/about" => "main#about"
  post "signin" => "sessions#create"
  get "signout" => "sessions#destroy", as: :signout
end
