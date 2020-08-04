Rails.application.routes.draw do

  devise_for :users
  root 'home#top'
  get 'home/about' => 'home#about'

  post 'follow/:id' => 'relationships#follow', as: 'follow'
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow'

  get 'search' => 'search#search'


  resources :users,only: [:show,:index,:edit,:update] do
    get 'users/follower' => 'users#follower'
    get 'users/followed' => 'users#followed'
  end

  resources :books,only: [:index,:show,:create,:update,:edit,:destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create,:destroy]
  end


end
