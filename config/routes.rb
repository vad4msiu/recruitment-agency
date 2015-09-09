Rails.application.routes.draw do
  root to: 'web/jobs#index'

  namespace :api do
    resources :skills, only: [] do
      collection do
        get :search
      end
    end
  end

  scope module: :web do
    resources :jobs, only: [:index, :new, :create, :show]
    resources :employees, only: [:index, :new, :create, :show]
  end
end
