Pickemup::Application.routes.draw do
  scope :auth do
    get '/github/callback', to: 'sessions#create'
    get '/linkedin_oauth2/callback', to: 'sessions#update'
  end
  scope '/', controller: :home do
    get :about
    get :contact
  end
  get "log_out" => "sessions#destroy", as: "log_out"
  resources :users, only: [:edit, :update] do
    member do
      get :resume
    end
  end
  require 'sidekiq/web'
  mount Sidekiq::Web, at: '/sidekiq'
  root 'home#index'
end
