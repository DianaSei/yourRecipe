Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
root "landing_page#index"

get 'food2fork/search'

resources :users
  resources :sessions, only: [:new, :create, :destroy]
  get 'signup', to: 'users#new', as: 'signup'
  get "login", to: "sessions#new", as: "sign_in"
  get 'sign_out', to: 'sessions#destroy', as: 'sign_out'


end
