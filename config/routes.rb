# frozen_string_literal: true

Rails.application.routes.draw do
  root 'posts#index'
  resources :users, only: %i[new create]
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  resources :posts, only: %i[index new create]
  delete '/logout', to: 'sessions#destroy'
end
