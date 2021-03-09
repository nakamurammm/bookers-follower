Rails.application.routes.draw do

  # get 'relationships/create'
  # get 'relationships/destroy'
  root 'homes#top'
  get 'home/about' => 'homes#about'

  devise_for :users
  resources :users,only: [:show,:index,:edit,:update] do
     resources :relationships, only: [:create, :destroy]
    member do
      get :followed, :followers
    end
  end
  resources :books

end