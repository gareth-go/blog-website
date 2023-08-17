# frozen_string_literal: true

Rails.application.routes.draw do
  resources :posts do
    member do
      put 'accept'
      put 'reject'
    end
  end
  devise_for :users, controllers: { sessions: 'users/sessions' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
end
