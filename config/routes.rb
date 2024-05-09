Rails.application.routes.draw do
  devise_for :users
  get "up" => "rails/health#show", as: :rails_health_check
  root 'home#index'
  resources :products
  resources :barcodes
  resources :orders
  resources :clients

  get "orders/new/find/product" => "orders#find_product", as: :find_product
end
