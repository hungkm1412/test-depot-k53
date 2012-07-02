SampleApp::Application.routes.draw do
  root to: "products#index"

  match "/help", to: "static_pages#help"
  match "/about", to: "static_pages#about"
  match "/contact", to: "static_pages#contact"

  match '/signup',  to: 'users#new'
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete

  match '/checkout', to: 'orders#new'

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :categories
  resources :products
  resources :cart_items, only: [:index, :create, :destroy]
  resources :orders
end
