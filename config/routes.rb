Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
root "landing_page#index"

get 'food2fork/search'
get 'search', to: 'landing_page#search', as: 'search'

resources :recipe, only: [:new, :create, :destroy]

resources :users do
	resources :recipe
end

resources :users
resources :sessions, only: [:new, :create, :destroy]
get 'signup', to: 'users#new', as: 'signup'
get "login", to: "sessions#new", as: "sign_in"
get 'sign_out', to: 'sessions#destroy', as: 'sign_out'
post '/users/:user_id/recipe/:id' => "users_recipe#create", as: 'user_recipe_create'
post "/recipe/:id/verify" => "recipe#verify", as: "verify"
post "/recipe/:id/unverify" => "recipe#unverify", as: "unverify"
post "/recipe/:id/votes" => "recipe#upvote", as: "vote"
get "/recipes/admin" => "recipe#admin", as: "admin"

end
