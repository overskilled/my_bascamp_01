Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  match '/users/:id' => 'home#show', via: :get
  get 'home/show'
  get 'users/:id', to: 'users#show', as: 'user'
  root to: "home#index"
  # Defines the root path route ("/")
  # root "articles#index"
end
