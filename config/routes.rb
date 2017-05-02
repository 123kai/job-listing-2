Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    resources :jobs do
      member do
        post :publish
        post :hide
      end

      resources :resumes
    end
  end

  resources :jobs do

    member do
      post :join
      post :quit
    end
    
    collection do
      get :search
      get :softengineer
      get :dataanalyst
      get :engineer
      get :business
      get :accounting
      get :writer
    end

    resources :resumes
    resources :categories
  end

  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
