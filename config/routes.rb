Rails.application.routes.draw do
  resources :corruption_cases, except: :show, param: :slug

  root to: "corruption_cases#index"
end
