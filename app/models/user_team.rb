# Pattern to be used in a n:m relation:
# http://stackoverflow.com/questions/1179930/activerecord-join-table-for-legacy-database

class UserTeam < ApplicationRecord
	self.table_name = 'userteam'
	belongs_to :user, foreign_key: 'idUser'
	belongs_to :team, foreign_key: 'idTeam'
end