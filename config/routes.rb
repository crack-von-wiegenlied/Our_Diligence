Rails.application.routes.draw do

  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  scope module: :public do
    root to: 'homes#top'
    get 'homes/about' => 'homes#about',as:'about'
    resources :users do
      resources :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
    get 'users/:id/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
    patch 'users/:id/withdraw' => 'users#withdraw', as: 'withdraw'
    resources :posts do
      resource :favorites, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
    resources :categories, only: [:create]
    get 'search' => 'searches#search'
  end

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
    resources :categories, only: [:index, :edit, :update]
    root to: 'users#index'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
