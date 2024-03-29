Rails.application.routes.draw do
  resources :user_stocks, only: [:create, :destroy]
  resources :friendships, only: [:index, :create]
  devise_for :users
  resources :users, only: [:show]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'welcome#index'
  get 'portfolio', to: 'users#portfolio'
  get 'search_stock', to: 'stocks#search'
  get 'search_friend', to: 'users#search'
  delete 'friendships', to: 'friendships#destroy'
end
