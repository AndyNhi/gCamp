Rails.application.routes.draw do

  resources :tasks
  resources :users
  resources :projects

  root 'pages#index'

  get '/about', to: 'about#about', as: :about
  get '/terms', to: 'term#term', as: :term
  get '/FAQ', to: 'faqs#faq', as: :faq
  get '/sign-out', to: 'authentication#destroy', as: :signout

  get '/sign-in', to: 'authentication#new', as: :signin
  post '/sign-in', to: 'authentication#create'

  get '/sign-up', to: 'users#new', as: :signup
  post '/sign-up', to: 'users#create'

end
