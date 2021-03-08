Rails.application.routes.draw do

  get 'relationships/create'
  get 'relationships/destroy'
  root 'homes#top'
  get 'home/about' => 'homes#about'
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update]
  resources :books

end