Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  as :user do
    get 'login'  => 'devise/sessions#new', as: :login
    get 'logout' => 'devise/sessions#destroy', as: :logout
    get 'signup' => 'devise/registrations#new', as: :signup
  end

  put 'checkout' => 'checkout#update_cart', as: :checkout_update
  root 'home#index'
  resources :books,       only: [:show]
  resources :addresses,   only: [:create]
  resources :categories,  only: [:show]
  resources :reviews,     only: [:create]
  resources :orders,      only: [:index, :show]
  resources :checkout
  resources :carts,       only: [:index, :update]
  resources :order_items, only: [:create, :destroy]
  resources :users,       only: [:edit, :update, :destroy]

  put 'settings' => 'users#update'
  get 'settings' => 'users#edit'
  get 'categories' => 'books#index', :as => 'categories'
end
