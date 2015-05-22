Rails.application.routes.draw do

   root 'questions#index'

   devise_for :users

   resources :users, only: [:index, :show]
  

  resources :questions, shallow: true do 
    resources :comments, except: [:new, :show]
    resources :answers, except: [:new, :show]
    resources :likes, only: [:create, :destroy]

    collection do 
      get 'unanswered'
    end
  end

  resources :answers, only: [], shallow: true do
    resources :comments, except: [:new, :show]
    resources :likes, only: [:create, :destroy]
  end

  get 'questions/course/:course_name', to: 'questions#show_with_tag', as: 'questions_from_subject'
  get 'questions/course/:course_name/number/:course_number', to: 'questions#show_with_tag', as: 'questions_from_course'

end
