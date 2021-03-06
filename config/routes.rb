# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  	root to: 'index#index'
	
	get 'index',     to: 'index#index'
	get 'more_info', to: 'index#more_info'
	get 'about_us',  to: 'index#about_us'
	post 'sign_up',  to: 'index#sign_up'
	post 'login',    to: 'index#login'
	
	get 'dashboard',        to: 'dashboard#index'
	get 'logout',           to: 'dashboard#logout'
	get 'profile',          to: 'dashboard#profile'
	post 'update_profile',  to: 'dashboard#update_profile'
	post 'update_password', to: 'dashboard#update_password'
	
	get 'teams',                to: 'team#index'
	get 'new_team',             to: 'team#new_team'
	get 'manage_team/:id',      to: 'team#manage_team'
	get 'update_team/:id',      to: 'team#update_team'
	get 'add_to_team/:id',      to: 'team#add_to_team'
	get 'find_user/:id',        to: 'team#find_user'
	get 'remove_from_team/:id', to: 'team#remove_from_team'
	post 'new_team',            to: 'team#new_team'
	post 'update_team',         to: 'team#update_team'
	post 'add_to_team',	        to: 'team#add_to_team'
	post 'remove_from_team',    to: 'team#remove_from_team'
	post 'delete_team',         to: 'team#delete_team'
end