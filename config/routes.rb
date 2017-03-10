Rails.application.routes.draw do
  devise_config = ActiveAdmin::Devise.config
  devise_config[:controllers][:omniauth_callbacks] = 'omniauth_callbacks'
  devise_for :users, devise_config
  ActiveAdmin.routes(self)

  devise_scope :user do
    get 'login' => 'active_admin/devise/sessions#new', as: :login
    get 'logout' => 'active_admin/devise/sessions#destroy', as: :logout
  end

  root 'home#index'
  resources :books, only: [:show]
  resources :categories, only: [:show, :index]
end
