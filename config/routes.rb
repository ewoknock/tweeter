Rails.application.routes.draw do
  devise_for :users, controllers: { 
      omniauth_callbacks: 'users/omniauth_callbacks' 
    }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'home#index'

  get :dashboard, to: "dashboard#index"
  get :bookmarks, to: "bookmarks#show"
  get :profile, to: "profile#show"
  get 'profile/likes', to: "profile#likes"
  get 'profile/replies', to: "profile#replies"
  get 'users/likes', to: "users#likes"
  get 'users/replies', to: "users#replies"

  get 'modal/tweet_form', to: "modal#tweet_form"



  resources :tweets, only: [:show, :create] do
    resources :likes, only: [:create, :destroy]
    resources :bookmarks, only: [:create, :destroy]
    resources :replies, only: :create
  end

  resources :usernames, only: [:new, :update]

  resources :users, only: :show do
    resources :follows, only: [:create, :destroy]
  end
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
