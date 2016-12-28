class IndexController < ApplicationController
	def index
	end

	def more_info
	end

	def about_us
	end
	
	def sign_up
		respond_to do |format|
			format.json do
				render json: {
					string: "áéíóú Ñôìüý",
					number: 34.544564,
					boolean: true,
					object: {
						array: [1, 2, 3, "4", false]
					},
					params: params
				}
			end
		end
	end
	
	def login
		respond_to do |format|
			format.json do
				render json: {
					params: params
				}
			end
		end
	end
end