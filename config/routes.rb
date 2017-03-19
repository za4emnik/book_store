Rails.application.routes.draw do
  devise_config = ActiveAdmin::Devise.config
  devise_config[:controllers][:omniauth_callbacks] = 'omniauth_callbacks'
  devise_for :users, devise_config
  ActiveAdmin.routes(self)

  devise_scope :user do
    get 'login' => 'active_admin/devise/sessions#new', as: :login
    get 'logout' => 'active_admin/devise/sessions#destroy', as: :logout
    get 'singup' => 'active_admin/devise/registrations#new', as: :singup
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
  resources :users,       only: [:edit] do
    patch 'update_billing'
    patch 'update_shipping'
    patch 'update_email'
    patch 'update_password'
  end

  get 'settings' => 'users#edit'
  get 'cart' => 'carts#index'
  get 'success' => 'orders#success'
end
