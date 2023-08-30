# frozen_string_literal: true

Rails.application.routes.draw do
  resources :posts, except: :index do
    resources :reactions, only: %i[create update destroy]
    resources :comments, only: %i[create]

    member do
      put 'accept'
      put 'reject'
    end
  end

  resources :comments, only: %i[update destroy] do
    resources :replies, only: %i[create update destroy], controller: 'comments'
  end

  namespace :dashboard do
    resources :tags
    resources :accounts, only: :index do
      member do
        put 'grant-admin'
        put 'revoke-admin'
        put 'ban'
        put 'unban'
      end
    end
    resources :posts, only: :index
  end

  namespace :settings do
    resources :profile, param: :username, only: %i[edit update]
    resources :password, param: :username, only: %i[edit update]
  end
  resources :users, param: :username, only: :show

  devise_for :users, path: ''

  root 'home#index'
end
