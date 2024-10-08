Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  root to: "pages#home"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/about', to: 'pages#about'
  get '/application', to: 'pages#application'
  get '/contact', to: 'pages#contact'
  get '/profile', to: 'pages#profile'

  get 'home', to: 'pages#home', as: 'home'
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :restaurants do
    resources :jobs, only: %w[new create]
  end

  resources :jobs, except: %w[new create] do
    resources :job_users, only: %w[create]
    resources :favorites, only: %w[create]
  end
end
