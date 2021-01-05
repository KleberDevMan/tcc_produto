Rails.application.routes.draw do
  get 'pages/denied'
  get 'pages/homepage'

  resources :menus
  resources :profiles

  resources :ideas do
    collection do
      get 'my_ideas'
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

  root 'pages#homepage'
end
