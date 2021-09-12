Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [] do
    resources :corruption_cases, only: :index
  end
  resources :corruption_cases, only:[:index, :show]

  namespace :my do
    resources :corruption_cases, except: :show, param: :slug , controller: 'corruption_cases'
  end

  resources :daily_corruption_reports, only: [:index, :show]

  root to: "corruption_cases#index"
end
