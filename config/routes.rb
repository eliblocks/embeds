Rails.application.routes.draw do
  mount ClipUploader.upload_endpoint(:cache) => "/clips/upload"
  mount Shrine.presign_endpoint(:cache) => "/clips/presign"


  root to: 'videos#index'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users
  resources :videos
  resources :accounts
  resources :plays
  resources :embeds

  get '/library', to: 'users#library'
  get '/account', to: 'accounts#show'
  get '/landing', to: 'embeds#landing'
end
