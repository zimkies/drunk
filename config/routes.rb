Rails.application.routes.draw do
  root to: 'marketing#index'
  resources :users
  resources :champions
end
