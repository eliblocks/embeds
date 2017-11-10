Rails.application.routes.draw do
  mount ClipUploader.upload_endpoint(:cache) => "/clips/upload"
  mount Shrine.presign_endpoint(:cache) => "/clips/presign"

  authenticated :user do
    root 'accounts#show', as: :authenticated_root
  end

  root to: 'static#welcome'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users
  resources :charges

  resources :videos do
    member do
      patch 'remove'
      patch 'restore'
    end
  end
  resources :plays
  resources :embeds

  get 'about', to: 'static#about'
  get 'contact', to: 'static#contact'
  get 'privacy', to: 'static#privacy'
  get 'terms', to: 'static#terms'

  patch 'accounts', to: 'accounts#update'
  get 'accounts/edit', to: 'accounts#edit'
  get 'accounts/show', to: 'accounts#show'
  get 'library', to: 'users#library'
  get 'account', to: 'accounts#show'
  get 'landing', to: 'embeds#landing'
  get 'video_test/:id', to: 'video_test#show'


  namespace :admin do
    get '', to: 'dashboard#index', as: '/'
    resources :users
    resources :videos
    get 'sessions/:id', to: 'sessions#impersonate', as: "impersonate"
  end




end
