Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    get "signup", to: "devise/registrations#new"
    get "login", to: "devise/sessions#new"
    get "logout", to: "devise/sessions#destroy"
  end

  root to: 'books#index'

  resources :books do
    resources :reviews, only: [:create, :edit, :update, :destroy]
  end

  namespace :admin do
    resources :users, only: [:index, :destroy]
  end
end
