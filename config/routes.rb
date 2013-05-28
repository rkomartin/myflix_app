Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  root to: 'genres#index'
  get '/home', to: 'genres#index'

  resources :genres, only: [:index, :show]  
  resources :videos, only: [:index, :show]

end
