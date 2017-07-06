Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'tasks#index'
  
  # task
  resources :tasks
  
  # session
  # get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  # user
  get 'signup', to: 'users#new'
  resources :users, only: [:index,:show, :new, :create]
  
end
