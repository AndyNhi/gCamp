Rails.application.routes.draw do

  root 'pages#index'

  get '/pages/task', to: 'pages#task'
  get '/pages/documents', to: 'pages#documents'
  get '/pages/comments', to: 'pages#comments'

end
