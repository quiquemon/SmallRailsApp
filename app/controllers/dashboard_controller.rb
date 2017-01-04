class DashboardController < ApplicationController
	before_action :require_login
	
	def index
	end
	
	def profile
		
	end
	
	def teams
		
	end
	
	def races
		
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