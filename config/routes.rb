Rails.application.routes.draw do
  resources :chats
  resources :chat_messages
  resources :products
  resources :histories
  resources :bookings
  resources :manage_bookings
  resources :profile
  resources :bills, only: [:index, :show]
  resources :users do
    collection do
      post :import
    end
  end
  resources :rooms do
    collection do
      post :import
    end
  end
  resources :carts do
    collection do
      patch :update_quantity
      post :checkout_momo
      get :checkout
    end
  end
  devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in' }
  root "welcome#index"
  get "shop", to: "welcome#shop"
  get "shop_detail/:id", to: "welcome#shop_detail", as: :shop_detail
  namespace :api do
    namespace :v1 do
      resources :bills, only: [:create]
    end
  end
end
