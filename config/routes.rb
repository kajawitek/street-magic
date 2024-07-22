# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  root 'home#index'

  resources :pods, only: %i[index show new create edit update]
  resources :pod_results, only: %i[new create]
end
