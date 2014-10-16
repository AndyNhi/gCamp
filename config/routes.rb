Rails.application.routes.draw do

  resources :tasks

  root 'pages#index'

  get '/about', to: 'about#about', as: :about
  get '/terms', to: 'term#term', as: :term
  get '/FAQ', to: 'faqs#faq', as: :faq

end
