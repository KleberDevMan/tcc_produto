Rails.application.routes.draw do
  get 'notifications/clear'

  resources :pages, only: :none do
    collection do
      get 'denied'
      get 'homepage'
      get 'terms_of_use'
      get 'set_cookie'
    end
  end

  resources :menus
  resources :profiles do
    member do
      get 'toggle_status'
    end
  end

  resources :notifications, only: [] do
    post 'clear', on: :collection
  end

  resources :ideas do
    collection do
      get 'my_ideas'
      post 'update_colaborators'
      post 'create_collaboration'
      delete 'destroy_collaboration'
      get 'dashboard'
      get 'update_state'
    end
  end

  resources :idea_categories do
    member do
      get 'toggle_status'
    end
  end

  resources :teachers do
    member do
      get 'toggle_status'
    end
  end

  resources :academic_works

  resources :courses do
    member do
      get 'toggle_status'
    end
  end

  devise_for :users
  resources :users
  devise_scope :user do
    get 'users/user_new' => 'users#new', as: 'user_new'
    post 'users/user_create' => 'users#create', as: 'user_create'
    put 'users/:id/user_update' => 'users#update', as: 'user_update'
  end

  root 'pages#homepage'
end
