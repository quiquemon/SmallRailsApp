class Team < ApplicationRecord
	self.table_name = 'team'
	has_many :user_team, foreign_key: 'idTeam'
	belongs_to :user, foreign_key: 'idUserOwner'
	
	validates :name, {
		presence: { message: 'El nombre es requerido.' },
		length: {
			maximum: 100,
			message: 'El nombre tiene un máximo de 100 caracteres.'
		}
	}
	validates :description, length: {
		maximum: 100,
		message: 'La descripción tiene un máximo de 100 caracteres.'
	}
	validates :memberNumber, numericality: {
		only_integer: true,
		greater_than_or_equal_to: 2,
		less_than_or_equal_to: 10,
		message: 'El equipo debe tener de 2 a 10 integrantes.'
	}
end