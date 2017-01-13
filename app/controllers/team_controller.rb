require 'rack'

class TeamController < ApplicationController
	include Rack::Utils
	before_action :set_team, only: [:manage_team, :update_team, :add_to_team, :find_user, :remove_from_team, :delete_team]
	before_action :verify_team_owner, only: [:update_team, :add_to_team, :find_user, :remove_from_team, :delete_team]
	
	def index
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
				team.idUserOwner = @user.id
				
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
		@users = @team.user_team.select(:idUser, :idTeam).distinct.to_a.collect { |record| record.user }
		@actual_users = @team.user_team.select(:idUser, :idTeam).distinct.where(idTeam: @team.id).count
	end

	def update_team
		if request.post?
			respond_to do |format|
				@team.name         = params[:name].blank?         ? '' : params[:name]
				@team.description  = params[:description].blank?  ? '' : params[:description]
				@team.memberNumber = params[:memberNumber].blank? ? 0  : params[:memberNumber]
				
				format.json do
					if @team.valid?
						if @team.user_team.count > @team.memberNumber
							return render json: {
								status: 1,
								errors: {
									memberNumber: ['Su equipo aún tiene integrantes. Por favor, elimine algunos miembros para poder reducir el tamaño del equipo.']
								}
							}
						else
							if @team.save
								return render json: {
									status: 0,
									message: 'El equipo se ha actualizado con éxito.',
									redirect: "/manage_team/#{@team.id}"
								}
							end
						end
					end
					
					render json: {
						status: 1,
						errors: @team.errors
					}
				end
			end
		end
	end

	def find_user
		respond_to do |format|
			records = User.where('email LIKE ? AND id NOT IN (SELECT ut.idUser FROM userteam ut, team t WHERE ut.idTeam = t.id and t.id = ?)',
				"%#{params[:email]}%", params[:id])
			
			format.json do
				if records.count > 0
					render json: {
						status: 0,
						message: 'Se encontraron los siguientes usuarios con un correo parecido:',
						users: records.to_a
					}
				else
					render json: {
						status: 1,
						message: 'No se encontró ningún correo electrónico parecido.'
					}
				end
			end
		end
	end
	
	def add_to_team
		if request.post?
			respond_to do |format|
				format.json do
					begin
						user = User.find(params[:idUser])
						full_name = "#{escape_html(user.name)} #{escape_html(user.lastname)}"
						@team.user_team.new(idUser: user.id, idTeam: @team.id).save
						render json: {
							status: 0,
							message: "El usuario <b>#{full_name}</b> ha sido agregado con éxito a su equipo.",
							user: {
								name: escape_html(user.name),
								lastname: escape_html(user.lastname),
								email: escape_html(user.email)
							}
						}
					rescue ActiveRecord::RecordNotFound
						render json: {
							status: 1,
							errors: {
								user: ["El usuario con el ID #{params[:idUser]} no existe."]
							}
						}
					end
				end
			end
		end
		
		@users = @team.user_team.select(:idUser, :idTeam).distinct.to_a.collect { |record| record.user }
		@is_the_team_complete = @team.memberNumber == @team.user_team.select(:idUser, :idTeam).distinct.where(idTeam: @team.id).count
	end

	def remove_from_team
	end

	def delete_team
	end
	
private
	def set_team
		begin
			@team = Team.find(params[:id])
		rescue ActiveRecord::RecordNotFound
			if request.xhr?
				respond_to do |format|
					format.json do
						render json: {
							status: 1,
							errors: {
								idTeam: ["No se encontró el equipo con el ID: #{params[:id]}. Por favor, pruebe a recargar la página."]
							}
						}
					end
				end
			else
				flash[:alert_type] = 'danger'
				flash[:notice] = 'Ese equipo no se encuentra disponible.'
				redirect_to '/teams'
			end
		end
	end
	
	def verify_team_owner
		if @team.user != @user
			if request.xhr?
				respond_to do |format|
					format.json do
						render json: {
							status: 1,
							errors: {
								idTeam: ['Usted no tiene los permisos para hacer cambios sobre este equipo.']
							}
						}
					end
				end
			else
				flash[:alert_type] = 'danger'
				flash[:notice] = 'Usted no tiene los permisos para hacer cambios sobre este equipo.'
				redirect_to '/teams'
			end
		end
	end
end