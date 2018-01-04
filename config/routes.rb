Rails.application.routes.draw do
  devise_for :users, path: 'users'
  get 'vacations/index'

  root 'vacations#index'


  devise_for :models
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
end
