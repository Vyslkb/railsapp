Rails.application.routes.draw do
  resources :posts
  resources :relationships, only: [:create, :destroy]
  root "posts#index"
  get 'user/:id' => "pages#profile"
  match 'like', to: 'likes#like', via: :post
  match 'unlike', to: 'likes#unlike', via: :delete
  devise_for :users
  resources :users do
    member do
      get :following, :followers
  end
end

#api
  namespace :api, defaults: { format: :json } do
  namespace :v1 do
    resources :posts
    devise_scope :user do
      post 'registrations' => 'registrations#create', :as => 'register'
      post 'sessions' => 'sessions#create', :as => 'login'
      delete 'sessions' => 'sessions#destroy', :as => 'logout'
    end
    get 'posts' => 'posts#index', :as => 'posts_all'
    post 'posts' => 'posts#create', :as => 'create_post'

    get 'users' => 'pages#search', :as => 'search'

    match 'like/:id', to: 'likes#like', via: :post
    match 'unlike/:id', to: 'likes#unlike', via: :delete

    match 'relationships/:id', to: 'relationships#create', via: :post
    match 'relationships/:id', to: 'relationships#destroy', via: :delete

    match 'users/:id', to: 'pages#profile', via: :get

  end
  end
end
