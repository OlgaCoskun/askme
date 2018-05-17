Rails.application.routes.draw do
  root 'users#index'

  # Ресурс пользователей (экшен destroy не поддерживается)
  resources :users, except: [:destroy]

  # ресурс сессий (только три экшена :new, :create, :destroy)
  resource :session, only: [:new, :create, :destroy]

  # Ресурс вопросов (кроме экшенов :show, :new, :index)
  resources :questions, except: [:show, :new, :index]
end
