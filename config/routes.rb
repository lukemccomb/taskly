Rails.application.routes.draw do
  root "task_lists#index"

  get "signin" => "sessions#new", as: :signin

  post "signin" => "sessions#create"

  get "signout" => "sessions#destroy", as: :signout

  get "/about" => "main#about", as: :about

  resources :task_lists do
    resources :tasks
  end

  get "/task_lists/:task_list_id/completed" => "task_lists#completed"
end
