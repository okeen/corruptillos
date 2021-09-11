Rails.application.routes.draw do
  devise_for :users
  resources :corruption_cases, except: :show, param: :slug

  root to: "corruption_cases#index"
end
