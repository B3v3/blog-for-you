Rails.application.routes.draw do
  get 'login',       to: 'sessions#new'
  post 'login',      to: 'sessions#create'
  delete 'logout',   to: 'sessions#destroy'

  resources :posts

  resources :users
  get 'users/:id/feed', to: 'users#feed', as: 'feed_user'
  get 'users/:id/followers', to: 'users#followers', as: 'followers_user'
  get 'users/:id/following', to: 'users#following', as: 'following_user'

  get 'register',    to: 'users#new'

  resources :follows,  only: [:create, :destroy]

  resources :likes,  only: [:create, :destroy]

  resources :comments, only: [:create, :update]

  root 'users#new'
end
