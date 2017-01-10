class TeamController < ApplicationController
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

	def manage_team
		record = @user.user_team.where(idTeam: params[:id])
		
		if record.exists?
			@team = record.first.team
			@users = UserTeam.where(idTeam: @team.id).to_a.collect { |record| record.user }
		else
			flash[:alert_type] = 'danger'
			flash[:notice] = 'Ese equipo no se encuentra disponible.'
			redirect_to '/teams'
		end
	end

	def join_team
	end

	def update_team
	end

	def add_to_team
	end

	def remove_from_team
	end

	def delete_team
	end
end