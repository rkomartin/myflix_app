Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  root to: 'pages#front'

  get '/home', to: 'genres#index'
  get '/register', to: 'users#new'
  get 'sign_in', to: 'sessions#new'
  get 'sign_out', to: 'sessions#destroy'
  
  resources :videos, only: [:index, :show] do
    collection do
      post :search, to: "videos#search"
    end
    
    resources :reviews, only: [:create]
  end

  get 'my_queue', to: "queue_items#index"
  resources :queue_items, only: [:create, :destroy]

  resources :genres, only: [:index, :show] 

  resources :users, only: [:create, :new]
  resources :sessions, only: [:create]
end
