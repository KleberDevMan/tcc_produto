Rails.application.routes.draw do
  resources :ideas do
    collection do
      get 'my_ideas'
    end
  end
  resources :idea_categories
  resources :teachers
  resources :academic_works
  resources :courses do
    member do
      get 'toggle_status'
    end
  end
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root "courses#index"
end
