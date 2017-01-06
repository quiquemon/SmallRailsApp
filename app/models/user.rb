class User < ApplicationRecord
	self.table_name = 'user'
	has_many :user_team, foreign_key: 'idUser'
	
	validates :name, {
		presence: { message: 'El nombre es requerido.' },
		length: {
			maximum: 100,
			message: 'El nombre tiene un máximo de 100 caracteres.'
		}
	}
	validates :lastname, {
		presence: { message: 'El apellido es requerido.' },
		length: {
			maximum: 100,
			message: 'El apellido tiene un máximo de 100 caracteres.'
		}
	}
	validate :is_older_than_18?
	validates :birthday,   presence: { message: 'La fecha de nacimiento es requerida.' }
	
	validate  :valid_email?
	validates :email, {
		presence: { message: 'El correo electrónico es requerido' },
		length: {
			maximum: 70,
			message: 'El correo electrónico tiene un máximo de 70 caracteres.'
		},
		uniqueness: {
			case_sensitive: false,
			message: 'Ese correo electrónico ya ha sido utilizado. Por favor, elija otro.'
		}
	}
	validates :password, {
		length: {
			in: 10..72,
			message: 'La contraseña debe tener entre 10 y 72 caracteres.'
		}
	}
	validate :valid_newsletter?
	
private
	def valid_email?
		valid_email_regex = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
		errors[:email] << 'La dirección de correo electrónico es inválida.' unless email =~ valid_email_regex || email.blank?
	end
	
	def is_older_than_18?
		errors[:birthday] << 'Debes ser mayor de edad para registrarte.' unless (birthday.to_date + 18.years) < Date.current
	end
	
	def valid_newsletter?
		errors[:newsletter] << 'El boletín es requerido.' unless newsletter.class == TrueClass || newsletter.class == FalseClass
	end
end