# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  get 'dashboard/index'

	root to: 'index#index'
	
	get 'index',     to: 'index#index'
	get 'more_info', to: 'index#more_info'
	get 'about_us',  to: 'index#about_us'
	post 'sign_up',  to: 'index#sign_up'
	post 'login',    to: 'index#login'
	
	get 'dashboard',        to: 'dashboard#index'
	get 'logout',           to: 'dashboard#logout'
	get 'profile',          to: 'dashboard#profile'
	get 'teams',            to: 'dashboard#teams'
	get 'races',            to: 'dashboard#races'
	post 'update_profile',  to: 'dashboard#update_profile'
	post 'update_password', to: 'dashboard#update_password'
end