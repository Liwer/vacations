Rails.application.routes.draw do

  resources :vacations do
  collection do
  end
end


  devise_for :users, path: 'users'

  root 'vacations#index'


  devise_for :models
	
   

end
