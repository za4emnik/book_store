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
  resources :books, only: [:show]
  resources :addresses, only: [:create]
  resources :categories, only: [:show, :index]
  resources :users, only: [:edit] do
    patch 'save_billing',  to: 'save_billing_address'
    patch 'save_shipping', to: 'save_shipping_address'
    patch 'save_email',    to: 'save_email'
    patch 'save_password', to: 'save_password'
  end
  get 'settings' => 'users#edit'
  get 'cart' => 'cart#show'
end
