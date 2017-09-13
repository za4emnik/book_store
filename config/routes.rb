Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  #devise_config = ActiveAdmin::Devise.config
  #devise_config[:controllers][:omniauth_callbacks] = 'omniauth_callbacks'
  #devise_for :users, devise_config
  #ActiveAdmin.routes(self)

  as :user do
    get 'login'  => 'devise/sessions#new', as: :login
    get 'logout' => 'devise/sessions#destroy', as: :logout
    get 'signup' => 'devise/registrations#new', as: :signup
  end

  root 'home#index'
  resources :books,       only: [:show]
  resources :addresses,   only: [:create]
  resources :categories,  only: [:index, :show]
  resources :reviews,     only: [:create]
  resources :orders,      only: [:index, :show]
  resources :checkout
  resources :carts,       only: [:index, :update]
  resources :order_items, only: [:create, :destroy]
  resources :users,       only: [:edit, :update, :destroy]# do
    #patch 'update_billing'
    #patch 'update_shipping'
    #patch 'update_email'
    #patch 'update_password'
  #end

  #get 'catalog', to: 'categories#index'
  put 'settings' => 'users#update'
  get 'settings' => 'users#edit'
  get 'cart' => 'carts#index', as: :cart_page
  #get 'success' => 'orders#success'
end
