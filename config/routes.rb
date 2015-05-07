Rails.application.routes.draw do

  root 'questions#index'

  devise_for :users

  resources :users, only: [:index, :show]
  resources :questions

end
