Rails.application.routes.draw do
  scope module: :cms do
  end

  namespace :cms do
    resources :users, only: %i[new create]
    resources :sessions, only: %i[new create destroy]
  end

  namespace :admin do
    resources :users, only: %i[new create]
    resources :sessions, only: %i[new create destroy]
    resources :home, only: %i[index]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
