Rails.application.routes.draw do
  get 'login',     to: 'sessions#new'
  post 'login',     to: 'sessions#create'
  delete 'logout',    to: 'sessions#destroy'

  get 'register',  to: 'users#new'


resources :posts
resources :users
root 'users#new'
end