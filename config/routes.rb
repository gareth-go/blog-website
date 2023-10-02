# frozen_string_literal: true

Rails.application.routes.draw do
  resources :posts, except: :index do
    member do
      put 'accept'
      put 'reject'
    end

    resources :reactions, only: %i[create update destroy]
    resources :comments, only: %i[create]
  end

  get '/readinglist', to: 'posts#readinglist', as: :readinglist

  resources :comments, only: %i[update destroy] do
    resources :replies, only: %i[create update destroy], controller: 'comments'
  end

  resources :tags, param: :name, only: %i[index show]

  namespace :dashboard do
    resources :tags
    resources :accounts, only: %i[index update]
    resources :posts, only: :index
  end

  namespace :settings do
    resources :profile, param: :username, only: %i[edit update]
    resources :password, param: :username, only: %i[edit update]
  end

  resources :users, param: :username, only: :show

  resources :notifications, only: :index

  resources :follows, only: %i[create destroy]

  resources :book_marks, only: %i[create destroy]

  mount ActionCable.server => '/cable'

  devise_for :users, path: '', controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  root 'home#index'
end
