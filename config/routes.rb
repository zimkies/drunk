Rails.application.routes.draw do
  root to: 'marketing#index'
  get :help, to: 'marketing#help'
  get :sign_in, to: 'users#sign_in'
  post :send_home_page, to: 'users#send_home_page'

  resources :users do
    resources :karma_events, only: :create
  end
  resources :champions
end
