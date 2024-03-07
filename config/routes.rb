Rails.application.routes.draw do
  devise_for :users, controllers: { 
      omniauth_callbacks: 'users/omniauth_callbacks' 
    }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'home#index'

  get :dashboard, to: "dashboard#index"
  get :bookmarks, to: "bookmarks#show"
  get :profile, to: "profile#show"

  resources :tweets, only: [:show, :create] do
    resources :likes, only: [:create, :destroy]
    resources :bookmarks, only: [:create, :destroy]
    resources :replies, only: :create
  end

  resources :usernames, only: [:new, :update]
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
