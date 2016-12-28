# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
	root to: 'index#index'
	
	get 'index/index'
	get 'more_info', to: 'index#more_info'
	get 'about_us', to: 'index#about_us'
	post 'sign_up', to: 'index#sign_up'
	post 'login', to: 'index#login'
end