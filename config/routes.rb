Rails.application.routes.draw do

	resources :users
	resources :attractions

	root 'welcome#home'

	get '/signin', to: 'sessions#new'
	post '/signin', to: 'sessions#create'
	delete '/signout', to: 'sessions#destroy'

	get '/rides/new', to: "rides#new"
	post '/rides', to: "rides#create"

end