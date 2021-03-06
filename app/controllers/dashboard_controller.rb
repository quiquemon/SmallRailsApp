require 'BCrypt'

class DashboardController < ApplicationController
	include BCrypt
	
	def index
	end
	
	def profile
	end
	
	def update_profile
		respond_to do |format|
			values = {
				name:       params[:name].blank?       ? ''           : params[:name],
				lastname:   params[:lastname].blank?   ? ''           : params[:lastname],
				birthday:   params[:birthday].blank?   ? '2000-01-01' : params[:birthday],
				email:      params[:email].blank?      ? ''           : params[:email],
				newsletter: params[:newsletter].blank? ? false        : params[:newsletter]
			}
			
			format.json do
				if @user.update(values)
					render json: {
						status: 0,
						message: 'Su información personal se ha actualizado con éxito.'
					}
				else
					render json: {
						status: 1,
						errors: @user.errors.values.flatten
					}
				end
			end
		end
	end
	
	def update_password
		respond_to do |format|
			format.json do
				if Password.new(@user.password) != params[:oldPassword]
					render json: {
						status: 1,
						errors: ['La contraseña actual es incorrecta.']
					}
				else
					@user.password = params[:newPassword]
					
					if @user.valid?
						@user.update(password: Password.create(params[:newPassword], cost: 14))
						render json: {
							status: 0,
							message: 'Su contraseña se ha actualizado con éxito.'
						}
					else
						render json: {
							status: 2,
							errors: @user.errors.values.flatten
						}
					end
				end
			end
		end
	end
	
	def logout
		reset_session
		redirect_to '/index'
	end
end