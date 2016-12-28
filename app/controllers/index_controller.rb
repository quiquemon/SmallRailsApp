class IndexController < ApplicationController
	def index
	end

	def more_info
	end

	def about_us
	end
	
	def sign_up
		params = {
			name: '',
			lastname: '',
			birthday: '',
			email: '',
			password: '',
			newsletter: ''
		}.merge(params)
		
		respond_to do |format|
			user = User.new
			user.name = params[:name]
			user.lastname = params[:lastname]
			user.birthday = params[:birthday]
			user.email = params[:email]
			user.password = params[:password]
			user.newsletter = params[:newsletter]
			
			if user.save
				format.json do
					render json: {
						string: 'User saved successfully!'
					}
				end
			else
				format.json do
					render json: {
						errors: user.errors
					}
				end
			end
		end
	end
	
	def login
		respond_to do |format|
			format.json do
				render json: {
					params: params
				}
			end
		end
	end
end