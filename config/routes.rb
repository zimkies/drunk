Rails.application.routes.draw do
  root to: 'marketing#index'
  get :help, to: 'marketing#help'

  resources :users do
    resources :karma_events, only: :create
  end
  resources :champions
end
