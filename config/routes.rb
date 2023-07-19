Rails.application.routes.draw do
  resources :products
  resources :carts do
    collection do
      patch :update_quantity
    end
  end
  devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in' }
  root "welcome#index"
  get "shop", to: "welcome#shop"
end
