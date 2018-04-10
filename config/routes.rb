Rails.application.routes.draw do
  resources :teams
  resources :matches
  resources :players
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "users#index"
  devise_for :users, :controllers => {:registrations => "registrations"}  

  resources :users

end
