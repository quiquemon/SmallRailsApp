class ApplicationController < ActionController::Base
	before_action :require_login
	
private
	def require_login
		return redirect_to '/index' if session[:user_id].blank?
		@user = User.find(session[:user_id])
	end
end