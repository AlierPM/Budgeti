Rails.application.routes.draw do

  resources :categories do
    resources :payments
  end

  get 'home/index'
  devise_for :users
  root 'home#index'
end
