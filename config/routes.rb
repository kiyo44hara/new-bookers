Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  root :to =>"homes#top"
  get "home/about"=>"homes#about"
  get '/search', to: 'searches#search'
  
  resources :groups, only: [:new, :create, :index, :show, :edit, :update, :destroy]do
    get "join" => "groups#join"
    get "new/mail" => "groups#new_mail"
    get "send/mail" => "groups#send_mail"
  end
  
  resources :chats, only: [:show, :create]

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update]do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
 
  
  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
  	get 'followings' => 'relationships#followings', as: 'followings'
  	get 'followers' => 'relationships#followers', as: 'followers'
    get "daily_posts" => "users#daily_posts"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
