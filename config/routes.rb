Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'home#index'
  get '/search', to: 'home#search'
  post '/search_hotel/:hotel_id', to: 'home#search_hotel', as: :search_hotel
  get '/check', to: 'home#check'
  get '/filter', to: 'home#filter'
  get '/load_more', to: 'home#load_more'
  get '/hotel/:id', to: 'home#hotel', as: :hotel
  get '/hotel/:id/check_tours', to: 'home#check_tours', as: :check_tours
  get '/hotel/:id/load_more_tours', to: 'home#load_more_tours', as: :load_more_tours
  get '/blog', to: 'blogs#index'
  get '/blog/:id', to: 'blogs#show'
  get '/blog/theme/:t_id', to: 'blogs#theme_show'
  get '/about', to: 'blogs#about'
  get '/operators', to: 'operators#index'
  get '/operator/:id', to: 'operators#show'
  get '/countries/category/:id', to: 'countries#show_region'
  get '/ajax', to: 'home#ajax'
  get '/form', to: 'blogs#form'
  post '/feedback', to: 'home#feedback', as: :reviews
  get '/tour/:id', to: 'home#tour'
  get '/tournext/:id', to: 'home#tournext'
  get '/buytour/:id', to: 'home#buytour'
  get '/thanks/:id', to: 'home#thanks'
  get '/resort_items/:id/:page', to: 'countries#resort_items'
  post '/feedback_phone', to: 'feedback#feedback_phone'
  post '/subscribe', to: 'feedback#subscribe'

  resources :countries, only: [:index, :show]
end
