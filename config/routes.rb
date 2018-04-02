require 'sidekiq/web'

Rails.application.routes.draw do

  #######API#########
  #https::/api.coursemate.io/v1/users

  constraints subdomain: 'api' do 
    namespace :api, defaults: {format: :json}, path: '/' do 
      scope module: :v1 do 
        resources :auth_tokens, only: [:create]
        resources :users, only: [:index]
      end
    end
  end

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

  resources :users, only: [:index, :show, :update] do 
    member do 
      get 'questions'
      get 'answers'
      get 'groups'
    end
  end

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
    member do 
      delete 'likes', to: 'likes#destroy', defaults: { type: "question" }
      post 'likes', to: 'likes#create', defaults: { type: "question" }
    end
  end

  resources :course_auto_completes, only: [:index]

  resources :answers, only: [], shallow: true do
    resources :comments, except: [:new, :show]
    member do 
      delete 'likes', to: 'likes#destroy', defaults: { type: "answer" }
      post 'likes', to: 'likes#create', defaults: { type: "answer" }
    end
  end

  resources :groups, shallow: true do 
    resources :comments, except: [:new, :show]
    member do
      delete 'enrollments', to: 'group_enrollments#destroy'
      post 'enrollments', to: 'group_enrollments#create'
    end
  end

  namespace :groups do 
    resources :cancelations, only: [] do 
      member do 
        patch 'cancel'
      end
    end
  end

  get 'subscriptions/:id/unsubscribe', to: 'subscriptions#unsubscribe', as: 'unsubscribe', id: "{{SECRET_TOKEN}}"

  resources :user_courses, only: [:create, :destroy]

  constraints course: /[\S\s]+/, university: /[\S\s]+/ do #necessary to pass the domain and course params as they are, otherwise queensu.ca will be passed as queenu only, this constraint escapes special chars.
    get 'groups/courses/:course', to: 'groups#show_from_course', as: 'show_groups_in_course'
    get 'questions/courses/:course', to: 'questions#show_from_course', as: 'show_questions_in_course'
    get 'groups/universities/:university', to: 'groups#show_from_university', as: 'show_groups_in_university'
    get 'questions/universities/:university', to: 'questions#show_from_university', as: 'show_questions_in_university'
  end

  namespace :questions do 
    #necessary to pass the domain and course params as they are, otherwise queensu.ca will be passed as queenu only, this constraint escapes special chars.
    constraints course: /[\S\s]+/, university: /[\S\s]+/ do
      get 'unanswered/:course', to: 'unanswered#index', as: 'unanswered'
    end
  end

end
