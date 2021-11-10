Rails.application.routes.draw do
  root 'homes#top'
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }

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
  get '/thanks' => 'users#thanks'

  resources :posts do
    resources :comments, only:[:create, :destroy] do
      get 'page/:page', :action => :show, :on => :collection
    end
    resource :favorites, only:[:create, :destroy]
  end

  resources :tags, except:[:show, :destroy]
  resources :categories, except:[:show, :destroy]
  resources :notifications, only:[:index, :destroy]
  resources :contacts, only:[:new, :create] do
    collection do
      post :confirm
      post :back
      get :complete
    end
  end
end
