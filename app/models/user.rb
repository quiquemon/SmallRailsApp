class User < ApplicationRecord
	self.table_name = 'user'
	
	validates :name,       presence: { message: 'El nombre es requerido.' }
	validates :lastname,   presence: { message: 'El apellido es requerido.' }
	validates :birthday,   presence: { message: 'La fecha de nacimiento es requerida.' }
	validates :email, {
		presence: { message: 'El correo electrónico es requerido' },
		uniqueness: { message: 'Ese correo electrónico ya ha sido utilizado. Por favor, elija otro.' }
	}
	validates :password,   presence: { message: 'La contraseña es requerida.' }
	validates :newsletter, presence: { message: 'El boletín es requerido.' }
end