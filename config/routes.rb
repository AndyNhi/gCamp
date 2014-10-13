Rails.application.routes.draw do

  root 'pages#index'

  get '/pages/task', to: 'pages#task', as: :task
  get '/pages/documents', to: 'pages#documents', as: :documents
  get '/pages/comments', to: 'pages#comments', as: :comments

  get '/about', to: 'about#about', as: :about
  get '/terms', to: 'term#term', as: :term
end
