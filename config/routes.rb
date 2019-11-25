Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
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
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
