Rails.application.routes.draw do


  devise_for :users
  resources :users, only: [:show, :index] do
  end
  root 'welcome#index'

end
