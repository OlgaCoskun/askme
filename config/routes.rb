Rails.application.routes.draw do

  root 'users#index'

  resources :users, except: [:destroy] # исключая действие удалить
  resources :questions

  # get 'users/index'
  #
  # get 'users/new'
  #
  # get 'users/edit'
  #
  # get 'users/show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get 'show' => 'users#show'
end
