Rails.application.routes.draw do
  root 'homes#top'
  devise_for :users

  get '/about' => 'homes#about'

  get '/tag_search' => 'searches#tag_search'
  get '/category_search' => 'searches#category_search'
  get '/word_search' => 'searches#word_search'

  resources :users do
    member do
      get :favorites
      get :comments
    end
  end
  # 退会確認画面用ルーティング
  get '/confirm' => 'users#confirm'

  resources :posts do
    resources :comments, only:[:create, :destroy]
    resource :favorites, only:[:create, :destroy]
  end

  resources :tags, only:[:index]
  resources :categories, only:[:index]
  resources :notifications, only:[:index, :destroy]

end
