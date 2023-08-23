# frozen_string_literal: true

Rails.application.routes.draw do
  resources :posts do
    resources :reactions, only: %i[create update destroy]
    resources :comments, only: %i[create update destroy] do
      resources :replies, only: %i[create update destroy], controller: 'comments'
    end

    member do
      put 'accept'
      put 'reject'
    end
  end
  devise_for :users, controllers: { sessions: 'users/sessions' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
end
