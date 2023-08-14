# frozen_string_literal: true

Rails.application.routes.draw do
  resources :posts, only: %i[new create show]
  get 'home/index'
  devise_for :users, controllers: { sessions: 'users/sessions' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
end
