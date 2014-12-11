Rails.application.routes.draw do

  root 'pages#index'

  resources :tracker_projects, only: [:show]
  resources :users
  resources :projects do
    resources :memberships
    resources :tasks do
      resources :comments, only: [:new, :create]
    end
  end



  get '/about', to: 'about#about', as: :about
  get '/terms', to: 'term#term', as: :term
  get '/FAQ', to: 'faqs#faq', as: :faq
  get '/sign-out', to: 'authentication#destroy', as: :signout

  get '/sign-in', to: 'authentication#new', as: :signin
  post '/sign-in', to: 'authentication#create'

  get '/sign-up', to: 'users#signup', as: :signup
  post '/sign-up', to: 'users#create'

end
