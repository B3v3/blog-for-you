Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'login',       to: 'sessions#new'
  post 'login',      to: 'sessions#create'
  delete 'logout',   to: 'sessions#destroy'

  resources :posts, except: [:index, :create]
  get 'posts', to: redirect('/posts/new')
  post 'posts/new', to: 'posts#create'

  resources :users, except: [:index, :create]
  get 'users', to: redirect('/register')
  get 'users/:id/feed', to: 'users#feed', as: 'feed_user'
  get 'users/:id/followers', to: 'users#followers', as: 'followers_user'
  get 'users/:id/following', to: 'users#following', as: 'following_user'
  post 'register', to: 'users#create'
  get 'register',    to: 'users#new'

  resources :follows,  only: [:create, :destroy]

  resources :likes,  only: [:create, :destroy]

  resources :comments, only: [:create, :update]

  resources :password_resets,     only: [:new, :create, :edit, :update]
  get 'password_resets', to: redirect('/password_resets/new')

  root 'sessions#new'
end
