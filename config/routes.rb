Rails.application.routes.draw do
  resources :users
  resources :questions
  resources :sessions,only:[:new,:create,:destroy]
end
