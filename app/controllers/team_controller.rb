class TeamController < ApplicationController
	before_action :set_team, only: [:manage_team, :update_team, :add_to_team, :remove_from_team, :delete_team]
	
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
	
	def join_team
	end

	def manage_team
		@users = @team.user_team.to_a.collect { |record| record.user }
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

	def add_to_team
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
end