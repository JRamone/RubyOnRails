Rails.application.routes.draw do
  resources :beer_clubs
  resources :users
  resources :beers
  resources :breweries
  root 'breweries#index'
  get 'kaikki_bisset', to: 'beers#index'
  resources :memberships, only: [:new, :create, :destroy]
  resources :ratings, only: [:index, :new, :create, :destroy]
  get 'signup', to: 'users#new'
  resource :session, only: [:new, :create, :destroy]
  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'
  get 'places', to: 'places#index'
  post 'places', to: 'places#search'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
