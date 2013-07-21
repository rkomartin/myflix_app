Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  root to: 'pages#front'

  get '/home', to: 'genres#index'
  get '/register', to: 'users#new'
  get 'sign_in', to: 'sessions#new'
  get 'sign_out', to: 'sessions#destroy'
  get 'people', to: 'relationships#index'
  get 'my_queue', to: "queue_items#index"
  get 'forgot_password', to: 'forgot_passwords#new'
  get 'forgot_password_confirmation', to: 'forgot_passwords#confirm'
  get 'expired_token', to: 'password_resets#expired_token'
  get 'register/:token', to: "users#new_with_invitation_token", as: 'register_with_token'

  post 'update_queue', to: 'queue_items#update_queue'

  resources :videos, only: [:index, :show] do
    collection do
      post :search, to: "videos#search"
    end
    
    resources :reviews, only: [:create]
  end

  namespace :admin do
    resources :videos, only: [:new, :create]
  end

  resources :queue_items, only: [:create, :destroy]
  resources :genres, only: [:index, :show] 
  resources :users, only: [:create, :new, :show]
  resources :relationships, only: [:create, :destroy]
  resources :sessions, only: [:create]
  resources :forgot_passwords, only: [:create]
  resources :password_resets, only: [:show, :create]
  resources :invitations, only: [:new, :create]
end
