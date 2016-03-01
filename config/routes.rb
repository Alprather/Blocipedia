Rails.application.routes.draw do

  devise_for :users
  resources :users, only: [:show, :index] do
    resources :wikis
  end
resources :wikis

  root 'welcome#index'

end
