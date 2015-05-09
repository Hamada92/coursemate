Rails.application.routes.draw do

   root 'questions#index'

   devise_for :users

   resources :users, only: [:index, :show]
  

  resources :questions, shallow: true do 
    #resources :comments, except: [:new, :show]
    resources :answers, except: [:new, :show]

    collection do 
      get 'unanswered'
    end
  end

  #resources :answers, only: [], shallow: true do
    #resources :comments, except: [:new, :show]
  #end







end
