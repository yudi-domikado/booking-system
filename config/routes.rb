Booking::Application.routes.draw do
  devise_for :users

  namespace :private do
    resources :orders
    resources :rooms
    resources :users do
      collection do
        get   :checkout
        match :profile, via: [:put, :get]
      end
    end
    root to: 'home#show', as: 'dashboard'
  end
  
  resources :carts
  resources :cart_items
  resources :rooms do
    member do
      get :info
    end
  end

  root to: 'home#show'

  get "/about",      to: 'pages#about'
  get "/contact",    to: 'pages#contact'

end
