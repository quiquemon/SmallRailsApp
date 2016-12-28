class UserTeam < ApplicationRecord
	belongs_to :user
	belongs_to :team
	
	self.table_name = 'userteam'
end