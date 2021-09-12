Rails.application.routes.draw do
  devise_for :users
  namespace :user do
    resources :corruption_cases, except: :show, param: :slug , controller: 'my_corruption_cases'
  end

  root to: "corruption_cases#index"
end
