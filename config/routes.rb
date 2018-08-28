Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "restaurants#index"
  resources :restaurants, only: [:index, :show] do
    resources :comments, only: [:create, :destroy]
    get :ranking, :on => :collection
    get :feeds, :on => :collection
    get :dashboard, :on => :member
    post :favorite, :on => :member
    post :unfavorite, :on => :member
    post :like, :on => :member
    post :unlike, :on => :member
    post :follow, :on => :member
  end
  resources :categories, only: [:show]
  resources :users, only: [:index, :show, :edit, :update] do
    member do
      post :follow
      post :unfollow
    end
  end

  namespace :admin do
    resources :restaurants
    resources :categories
    root "restaurants#index"
  end

end
