=begin
Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  get 'home', to: 'home#home', as: 'home'

  get '/users/sign_out', to: 'devise/sessions#destroy', as: :user_sign_out

  resources :projects

  get '/users/:id', to: 'home#show', as: 'user'

  get 'toggle_role', to: 'user#set_role', as: 'toggle_role'

  # Define your additional application routes here

  # Example:
  # get '/example', to: 'example#action'

  # Keep the default "match" line only if you have a specific reason to use it
  # match '/users/:id' => 'home#show', via: :get

  # Redirect authenticated users to home page after sign in
  authenticated :users do
    root 'home#home', as: :authenticated_root
  end

  # Redirect unauthenticated users to login page after sign in
  unauthenticated :users do
    root 'home#index', as: :unauthenticated_root
  end

end
=end


Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  resources :projects
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # routes.rb
  get 'home/welcome', to: 'home#welcome', as: 'home_welcome'

  match '/users/:id' => 'home#show', via: :get

  get 'home/show'
  # routes.rb
  get 'toggle_role', to: 'home#user_set_role_path', as: 'toggle_role'


  get 'users/:id', to: 'users#show', as: 'user'
  #root to: "users#show"
  root to: "home#index"
  # Defines the root path route ("/")
  # root "articles#index"
end

