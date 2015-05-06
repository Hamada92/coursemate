Rails.application.routes.draw do

  root 'questions#index'

  devise_for :users

  resources :questions
end
