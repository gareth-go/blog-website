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
    resources :posts, only: :index
  end
  devise_for :users, controllers: { sessions: 'users/sessions' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
end
