Rails.application.routes.draw do

  root 'questions#index'

  devise_for :users

  resources :users, only: [:index, :show]
  resources :questions do
    resources :comments
    resources :answers, except: [:new, :show] do
    collection do 
      get 'unanswered'
    end
  end
  resources :answers do
    resources :comments
  end



end
