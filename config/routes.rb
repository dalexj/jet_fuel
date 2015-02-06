Rails.application.routes.draw do
  root 'links#index'

  resources :links, only: [:create]
  get '/links/:slug', to: 'links#show'
end
