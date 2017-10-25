Rails.application.routes.draw do
  mount ClipUploader.upload_endpoint(:cache) => "/clips/upload"
  mount Shrine.presign_endpoint(:cache) => "/clips/presign"


  root to: 'videos#index'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users
  resources :videos
  resources :plays
  resources :embeds

  patch '/accounts', to: 'accounts#update'
  get 'accounts/edit', to: 'accounts#edit'
  get 'accounts/show', to: 'accounts#show'
  get '/library', to: 'users#library'
  get '/account', to: 'accounts#show'
  get '/landing', to: 'embeds#landing'
end
