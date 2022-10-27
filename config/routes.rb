Rails.application.routes.draw do

 devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end


  scope module: :public do
    root to: 'homes#top'
    resources :users do
      resources :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
      get 'favorites' => 'favorites#index', as: 'favorites'
    end
    get 'users/:id/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
    patch 'users/:id/withdraw' => 'users#withdraw', as: 'withdraw'
    get 'posts/timeline' => 'posts#timeline', as: 'timeline'
    resources :posts do
      resource :favorites, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
    resources :categories, only: [:show]
    resources :opinions, only: [:new, :create, :index]
    get 'search' => 'searches#search'
  end

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
    resources :categories, only: [:create, :index, :edit, :update, :destroy]
    resources :posts, only: [:index, :show, :destroy]
    get 'opinions' => 'opinions#index'
    root to: 'users#index'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
