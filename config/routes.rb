Rails.application.routes.draw do
  root to: 'marketing#index'
  resources :users do
    resources :karma_events, only: :create
  end
  resources :champions
end
