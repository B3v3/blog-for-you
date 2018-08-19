Rails.application.routes.draw do
  get 'login',       to: 'sessions#new'
  post 'login',      to: 'sessions#create'
  delete 'logout',   to: 'sessions#destroy'

  get 'register',    to: 'users#new'

  post 'follow',     to: 'follows#create'
  delete 'unfollow', to: 'follows#destroy'

  post 'comment',    to: 'comments#create'
  patch 'comment',    to: 'comments#update'

resources :posts
resources :users
root 'users#new'
end
