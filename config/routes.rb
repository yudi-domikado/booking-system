Booking::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users
  ActiveAdmin.routes(self)
  resources :users do
    get :check_in, on: :collection
    get :check_out, on: :collection
    get :checkout, :on => :collection # collection ga pake id sedangkan member  pake id
  end

  resources :rooms do
    member do
      get :info
    end
  end
  resources :carts
  resources :cart_items
  resources :topups
  resources :orders
  root to: 'pages#home'

  get "/about",      to: 'pages#about'
  get "/contact",    to: 'pages#contact'

end
