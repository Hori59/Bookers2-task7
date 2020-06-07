Rails.application.routes.draw do
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update] do
    member do
      get :following, :followers
    end
  end

  resources :books do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]

  root 'home#top'
  get 'home/about'
  get 'search' => 'search#search'
end