Rails.application.routes.draw do
  resources :corruption_cases, except: :show

  root to: "corruption_cases#index"
end
