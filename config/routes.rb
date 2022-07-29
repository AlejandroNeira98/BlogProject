Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', registration: 'users/registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "users#index"
  get '/', to: 'users#index'

  get '/login', to: 'login#index'

  resources :likes, only: [ :create ]

  resources :users, only: [ :index, :show ] do
    resources :posts, only: [:index, :show, :new, :create] do
      resources :comments, only: [ :create, :new ]
    end
  end
end
