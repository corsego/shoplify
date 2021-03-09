Rails.application.routes.draw do
  devise_for :users
  root "products#index"
  resources :products
  post "checkout/create", to: "checkout#create"
  resources :webhooks, only: [:create]
end
