Rails.application.routes.draw do

  root 'pages#index'

  get '/task', to: 'pages#task'
  get '/documents', to: 'pages#documents'
  get '/comments', to: 'pages#comments'

end
