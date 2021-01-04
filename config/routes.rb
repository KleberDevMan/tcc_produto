Rails.application.routes.draw do
  get 'msg_errors/denied'
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
  resources :users do
    collection do
      get "alterar_perfil"
    end
  end

  root "courses#index"
end
