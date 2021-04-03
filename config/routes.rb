Rails.application.routes.draw do
  resources :sessions, only: %i[new create destroy]
  namespace :cms do
    resources :users, only: %i[new create]
  end
  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
