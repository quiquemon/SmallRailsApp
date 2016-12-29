require 'BCrypt'

class IndexController < ApplicationController
	include BCrypt
	
	def index
	end

	def more_info
	end

	def about_us
	end
	
	def sign_up
		respond_to do |format|
			user = User.new
			user.name       = params[:user].blank?       ? ''           : params[:user]
			user.lastname   = params[:lastname].blank?   ? ''           : params[:lastname]
			user.birthday   = params[:birthday].blank?   ? '2000-01-01' : params[:birthday]
			user.email      = params[:email].blank?      ? ''           : params[:email]
			user.password   = params[:password].blank?   ? ''           : params[:password]
			user.newsletter = params[:newsletter].blank? ? '0'          : params[:newsletter].to_s
			
			if user.valid? # Validate password first.
				user.password = Password.create(user.password, cost: 14)
				if user.save
					format.json do
						render json: {
							string: 'User saved successfully!'
						}
					end
				end
			end
			
			format.json do
				render json: {
					errors: user.errors
				}
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