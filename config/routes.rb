  Rails.application.routes.draw do
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
      post 'registrations' => 'registrations#create'
      put 'update' => 'registrations#update'
      post 'sessions' => 'sessions#create'
      delete 'sessions' => 'sessions#destroy'
      get :following, :followers
    end

    get 'index' => 'posts#index'

    get 'post/:id' => 'posts#show'

    get 'post/:id/comments' => 'posts#get_comments' 

    post 'posts' => 'posts#create'

    post 'post/:post_id/comments/:content' => 'comments#create'

    delete 'post/:id' => 'posts#destroy'

    put 'post/:id/update' => 'posts#update'

    delete 'post/:post_id/comments/:id' => 'comments#destroy'

    get 'search/:search' => 'pages#search', :constraints => { :search => /.*/ }

    get 'username/:username_search' => 'searches#username_search', :constraints => { :username_search => /.*/ }

    get 'email/:email_search' => 'searches#email_search', :constraints => { :email_search => /.*/ }

    get 'profile' => 'pages#self'

    get 'profile/posts' => 'pages#get_self_posts'

    get 'users/:id' => 'pages#profile'

    get 'user/:id/posts' => 'pages#get_user_posts'

    match 'like/:id', to: 'likes#like', via: :post

    match 'unlike/:id', to: 'likes#unlike', via: :delete

    match 'relationships/:id', to: 'relationships#create', via: :post

    match 'relationships/:id', to: 'relationships#destroy', via: :delete

    match 'users/:id', to: 'pages#profile', via: :get
    
    post 'account/reset_password/:email' => 'accounts#reset_password', :constraints => { :email => /.*/ }

    post 'block/:id' => 'blocks#create'

    delete 'block/:id' => 'blocks#destroy'

    get 'blocks' => 'blocks#blocks'

    get 'followers/:id' => 'relationships#followers'

    get 'followings/:id' => 'relationships#following'

    get 'profile/followers' => 'relationships#current_user_followers'

    get 'profile/following' => 'relationships#current_user_following'

    get 'likes/:id' => 'likes#likes'

  end
  end
end
