Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :projects do
    member do
      post 'share'
      post 'edit_project_name'
      post 'edit_project_desc'
      post 'add_user'
      post 'update_user'
      delete 'delete'
      post 'change_role'
    end
  end

  post '/projects/:id/update_role', to: 'projects#update_role', as: :update_role_project

  patch 'projects/:id', to: 'projects#update'

  resources :user do
    post 'join_project', on: :member
  end

  get 'users/welcome', to: 'users#welcome', as: 'home_welcome'
  get 'users/show' # Note: This route might be duplicated, consider removing it if not needed.


  #get 'users/:id', to: 'users#welcome' as: :user

  # Add the 'toggle_role' route, assuming it's related to user roles
  get 'toggle_role', to: 'users#user_set_role_path', as: 'toggle_role'

  # Root route
  root to: "users#index"
end
