require 'BCrypt'

class DashboardController < ApplicationController
	include BCrypt
	
	before_action :require_login
	
	def index
	end
	
	def profile
	end
	
	def teams
		user_team_array = @user.user_team.to_a.in_groups_of(3)
		@teams = user_team_array.collect do	|user_team|
			user_team.collect { |record| record.team unless record.nil? }
		end
	end
	
	def new_team
		if request.post?
			respond_to do |format|
				team = Team.new
				team.name         = params[:name].blank?         ? '' : params[:name]
				team.description  = params[:description].blank?  ? '' : params[:description]
				team.memberNumber = params[:memberNumber].blank? ? 0  : params[:memberNumber]
				team.creationDate = Date.current.to_s
				team.code = SecureRandom.hex(8)
				
				format.json do
					if team.save
						@user.user_team.new(idUser: @user.id, idTeam: team.id).save
						render json: {
							status: 0,
							message: 'El equipo se ha creado con éxito.'
						}
					else
						render json: {
							status: 1,
							errors: team.errors
						}
					end
				end
			end
		end
	end
	
	def manage_team
		
	end
	
	def join_team
		
	end
	
	def races
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
						errors: @user.errors
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
						errors: { password: ['La contraseña actual es incorrecta.'] }
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
							errors: @user.errors
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
	
private
	def require_login
		redirect_to '/index' unless !session[:user_id].blank?
		@user = User.find(session[:user_id])
	end
end