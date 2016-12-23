# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
	root to: 'index#index'
	
	get 'index/index'
	get 'index/more_info'
	get 'index/about_us'
end