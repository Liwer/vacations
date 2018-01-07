Rails.application.routes.draw do

  resources :vacations do
  collection do
    # get 'vacation_new'
    # post 'vacation_create'
  end
end


  devise_for :users, path: 'users'

  root 'vacations#index'


  devise_for :models
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
end
