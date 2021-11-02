Rails.application.routes.draw do
  root 'posts#index'
  devise_for :users

  get '/about' => 'homes#about'

  get '/tag_search' => 'searches#tag_search'
  get '/category_search' => 'searches#category_search'

  resources :users
  # 退会確認画面用ルーティング
  get '/confirm' => 'users#confirm'

  resources :posts do
    resources :comments, only:[:create, :destroy]
    resource :favorites, only:[:create, :destroy]
  end

  resources :tags, only:[:index]
  resources :categories, only:[:index]

end
