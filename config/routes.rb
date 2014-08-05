Rails.application.routes.draw do
  root "task_lists#index"
  get "signin" => "sessions#new", as: :signin
  post "signin" => "sessions#create"
  get "signout" => "sessions#destroy", as: :signout
  get "/about" => "main#about"
  get "/addtasklist" => "task_lists#create_page"
  post "/task_list/new" => "task_lists#create"
end
