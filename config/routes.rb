Rails.application.routes.draw do
  resources :matches
  resources :match_details
  resources :games
  resources :teams
  resources :players
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "users#index"
  devise_for :users, :controllers => {:registrations => "registrations"}  

  resources :users

  get '/calculate_scores', to: 'games#calculate_scores'
  # get '/find_winner', to: 'match_details#index'
  get '/populate_other_list', to: 'games#populate_other_list'
end
