Rails.application.routes.draw do

  # на главной странице список юзеров
  root 'users#index'

  resources :users
  
  # ресурс сессий (только три экшена :new, :create, :destroy)
  resource :session, only: [:new, :create, :destroy]
  
  # ресурс вопросов (кроме экшенов :show, :new, :index)
  resources :questions, only: [:edit, :create, :update, :destroy]
end
