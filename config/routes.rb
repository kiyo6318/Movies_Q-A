Rails.application.routes.draw do
  root 'questions#index'
  resources :users
  resources :questions do
    resources :answers
    resources :likes, only: [:create, :destroy]
  end
  resources :sessions,only:[:new,:create,:destroy]
end
