require 'sidekiq/web'

Rails.application.routes.draw do

  authenticated :user do
    root "groups#show_from_my_university", as: :authenticated_root
  end

  root "groups#index"

  devise_for :users, :path => 'account', :path_names => { :edit => "edit_account" }

  # SIDEKIQ
  authenticate :user, lambda { |u| u.is_master? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  get 'account/edit_profile', to: 'users#edit'

  resources :users, only: [:index, :show, :update]
  resources :notifications, only: [:index] do 
    member do 
      patch 'mark_read'
    end
    collection do 
      get 'top_notifications'
    end
  end

  resources :questions, shallow: true do 
    resources :comments, except: [:new, :show]
    resources :answers, except: [:new, :show]
    collection do 
      get 'autocomplete', to: 'questions#set_university_autocomplete'
    end
    member do 
      delete 'likes', to: 'likes#destroy', defaults: { type: "question" }
      post 'likes', to: 'likes#create', defaults: { type: "question" }
    end
  end

  resources :answers, only: [], shallow: true do
    resources :comments, except: [:new, :show]
    member do 
      delete 'likes', to: 'likes#destroy', defaults: { type: "answer" }
      post 'likes', to: 'likes#create', defaults: { type: "answer" }
    end
  end

  resources :groups, shallow: true do 
    resources :group_enrollments, only: [:create, :destroy], as: 'enrollments'
    resources :comments, except: [:new, :show]
    collection do 
      get 'autocomplete', to: 'groups#set_university_autocomplete'
    end
  end

  namespace :groups do 
    resources :cancelations, only: [] do 
      member do 
        patch 'cancel'
      end
    end
  end

  constraints course: /[\S\s]+/, university: /[\S\s]+/ do #necessary to pass the domain and course params as they are, otherwise queensu.ca will be passed as queenu only, this constraint escapes special chars.
    get 'groups/courses/:course', to: 'groups#show_from_course', as: 'show_groups_in_course'
    get 'questions/courses/:course', to: 'questions#show_from_course', as: 'show_questions_in_course'
    get 'groups/universities/:university', to: 'groups#show_from_university', as: 'show_groups_in_university'
    get 'questions/universities/:university', to: 'questions#show_from_university', as: 'show_questions_in_university'
  end

  get 'questions/unanswered/:tag_id', to: 'questions#unanswered_with_tag', as: 'unanswered_with_tag'

end
