Rails.application.routes.draw do
  get 'relationships/create'
  get 'relationships/destroy'
  root 'questions#index'
  resources :users do
    member do
      get 'relations',to: 'users#relations'
    end
  end
  resources :questions do
    resources :answers
    resources :likes, only: [:create, :destroy]
  end
  resources :sessions,only:[:new,:create,:destroy]
  resources :relationships, only:[:create, :destroy]
end
