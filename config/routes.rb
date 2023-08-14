# frozen_string_literal: true

Rails.application.routes.draw do
  # get 'posts/new', to: 'posts#new', as: :new_post
  # get 'post/:id', to: 'posts#show', as: :post
  # post 'posts', to: 'posts#create', as: :posts
  resources :posts
  get 'home/index'
  devise_for :users, controllers: { sessions: 'users/sessions' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
end
