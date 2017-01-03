require 'BCrypt'

class IndexController < ApplicationController
	include BCrypt
	
	def index
		if !session[:user_id].blank?
			redirect_to '/dashboard'
		end
	end

	def more_info
	end

	def about_us
	end
	
	def sign_up
		respond_to do |format|
			user = User.new
			user.name       = params[:name].blank?       ? ''           : params[:name]
			user.lastname   = params[:lastname].blank?   ? ''           : params[:lastname]
			user.birthday   = params[:birthday].blank?   ? '2000-01-01' : params[:birthday]
			user.email      = params[:email].blank?      ? ''           : params[:email]
			user.password   = params[:password].blank?   ? ''           : params[:password]
			user.newsletter = params[:newsletter].blank? ? '0'          : params[:newsletter]
			
			if user.valid? # Validate password first.
				user.password = Password.create(user.password, cost: 14)
				if user.save
					reset_session
					session[:user_id] = user.id
					format.json do
						render json: {
							status: 0
						}
					end
				end
			end
			
			format.json do
				render json: {
					status: 1,
					errors: user.errors
				}
			end
		end
	end
	
	def login
		begin
			user = User.find_by_email!(params[:email])
			raise ActiveRecord::RecordNotFound unless Password.new(user.password) == params[:password]
			reset_session
			session[:user_id] = user.id
			respond_to do |format|
				format.json do
					render json: {
						status: 0
					}
				end
			end
		rescue ActiveRecord::RecordNotFound
			respond_to do |format|
				format.json do
					render json: {
						status: 1,
						error: 'El correo o la contraseña son erróneas.'
					}
				end
			end
		end
	end
end