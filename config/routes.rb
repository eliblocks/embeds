Rails.application.routes.draw do
  mount ClipUploader.upload_endpoint(:cache) => "/clips/upload"
  mount Shrine.presign_endpoint(:cache) => "/clips/presign"

  root to: 'videos#index'
  devise_for :users
  resources :users
  resources :videos

  get '/library', to: 'users#library'
end
