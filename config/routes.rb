Rails.application.routes.draw do


  devise_for :users
  resources :users, only: [:show, :index] do
    resources :wikis
  end
resources :wikis
resources :charges, only: [:new, :create]
  root 'welcome#index'

end
