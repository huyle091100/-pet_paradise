Rails.application.routes.draw do
  resources :chats
  resources :chat_messages
  resources :products
  resources :users do
    collection do
      post :import
    end
  end
  resources :carts do
    collection do
      patch :update_quantity
      post :checkout
    end
  end
  devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in' }
  root "welcome#index"
  get "shop", to: "welcome#shop"
  namespace :api do
    namespace :v1 do
      resources :bills, only: [:create]
    end
  end
end
