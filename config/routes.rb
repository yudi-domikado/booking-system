Booking::Application.routes.draw do
  devise_for :users

  namespace :private do
    resources :orders
    resources :room_orders do
      get :checkout, on: :collection
    end
    resources :rooms
    resources :companies
    resources :users do
      collection do
        match :profile, via: [:put, :get]
      end
    end
    root to: 'home#show', as: 'dashboard'
  end
  
  resources :room_cart,  only: [:create, :destroy]
  resources :room, only: [:show]

  root to: 'home#show'

  get '/about',      to: 'pages#about'
  get '/contact',    to: 'pages#contact'
  get '/room/:info(/:gon_watched_variable)', to: 'room#show'
  get '/private/pending-rooms', to: 'private/home#pending_booking_rooms'
  get '/private/total-pending-rooms', to: "private/home#total_pending_booking_rooms" 
end
